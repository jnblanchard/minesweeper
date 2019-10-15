import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Board with ChangeNotifier {

  // beginner       9x9 w/10
  // intermediate   16x16 w/ 40
  // expert         16x30 w/ 99
  // custom         hxw w/ m
  int height = 9;
  int width = 9;
  int mines = 10;

  bool isBlownUp = false;

  int secondsGoneBy = 0;
  Timer _gameTimer = null;

  List<Point> mineLocations = [];
  List<Point> flagLocations = [];
  List<List<String>> board = List<List<String>>.generate(9, (i) => List<String>.generate(9, (j) => ""));

  changeBoard({int height = 9, int width = 9, int mines = 10}) {
    this.height = height;
    this.width = width;
    this.mines = mines;

    _gameTimer.cancel();
    secondsGoneBy = 0;

    mineLocations = [];
    flagLocations = [];

    isBlownUp = false;
    board = List<List<String>>.generate(height, (i) => List<String>.generate(width, (j) => ""));

    notifyListeners();
  }

  _showMines() {
    isBlownUp = true;
    for (var i = 0; i < mines; i++) {
      Point mine = mineLocations[i];
      board[mine.x][mine.y] = "M";
      notifyListeners();
    }
  }

  _sweep(Point location) {

    bool isOnBoard = location.x >= 0 && location.x < width && location.y >= 0 && location.y < height;

    if (!isOnBoard || mineLocations.contains(location) || flagLocations.contains(location) || board[location.x][location.y].compareTo("") != 0 ) {
      return;
    }

    final left = Point(location.x-1, location.y);
    final right = Point(location.x+1, location.y);
    final bottom = Point(location.x, location.y+1);
    final top = Point(location.x, location.y-1);
    final topLeft = Point(location.x-1, location.y-1);
    final bottomLeft = Point(location.x-1, location.y+1);
    final topRight = Point(location.x+1, location.y-1);
    final bottomRight = Point(location.x+1, location.y+1);

    List<Point> neighbors = [left, right, bottom, top, topLeft, bottomLeft, topRight, bottomRight];

    int sweepCount = neighbors.fold(0, (count, next) => mineLocations.contains(next) ? count + 1 : count);

    board[location.x][location.y] = sweepCount.toString();

    notifyListeners();

    // Open a square w/ 0 bomb neighbors, open all neighbors.
    if (sweepCount == 0) {
      _sweep(left);
      _sweep(right);
      _sweep(bottom);
      _sweep(top);
      _sweep(topLeft);
      _sweep(bottomLeft);
      _sweep(topRight);
      _sweep(bottomRight);
    }


  }

  _createBoard(Point origin) {

    int _randomNum() => Random().nextInt((height*width));

    Point _locationFrom(int val) => Point(val % width, (val / width).floor());

    Point _randomNotOriginOrExisting() {
      var randomLocation = _locationFrom(_randomNum());
      if (randomLocation == origin || mineLocations.contains(Point(randomLocation.x, randomLocation.y))) {
        return _randomNotOriginOrExisting();
      } else {
        return randomLocation;
      }
    }

    mineLocations = [];
    for (var i = 0; i < mines; i++) {
      var randomLocation = _randomNotOriginOrExisting();
      mineLocations.add(Point(randomLocation.x, randomLocation.y));
    }

  }

  tap(Point location) {
    if (mineLocations.isEmpty) {
      _gameTimer = Timer.periodic(Duration(seconds: 1), (time) {
        secondsGoneBy = time.tick;

        if (secondsGoneBy == 999) _showMines();

        notifyListeners();
      });

      _createBoard(location);
    }

    if (mineLocations.contains(location)) {
      _showMines();
    } else {
      _sweep(location);
    }

  }

  flag(Point location) {
    if (_gameTimer != null) {
      if (flagLocations.contains(location)) {
        board[location.x][location.y] = "";
        flagLocations.remove(location);
      } else {
        board[location.x][location.y] = "!";
        flagLocations.add(Point(location.x, location.y));

        /* Incorrectly identifying a mines does not kill you
        if (flagLocations.length == mines) {
          for (var i = 0; i < flagLocations.length; i++) {
            var flagLocation = flagLocations[i];
            if (!mineLocations.contains(flagLocation)) {
              isBlownUp = true;
              _showMines();
              return;
            }
          }
        }
        */

      }
      notifyListeners();
    }
  }


}