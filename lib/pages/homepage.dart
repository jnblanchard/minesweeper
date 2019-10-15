import 'package:flutter/material.dart';
import 'package:minesweeper/views/top_board.dart';
import 'package:minesweeper/views/game_board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    var gameCol = Column(children: <Widget>[TopBoard(), GameBoard()]);

    return Scaffold(body: gameCol);
  }
}

