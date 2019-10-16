import 'package:flutter_web/material.dart';
import 'package:minesweeper/providers/board.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {

    var boardProvider = Provider.of<Board>(context);

    List<Row> rows = [];
    for (var i = 0; i < boardProvider.height; i++) {

      List<Widget> cells = [];
      for(var j = 0; j < boardProvider.width; j++) {

        var cellData = boardProvider.board[i][j];

        var label = cellData.compareTo("M") == 0 && !boardProvider.isBlownUp ? "" : cellData;

        var cell = GestureDetector(onSecondaryTapDown: (_) => boardProvider.flag(Point(i, j)),
                                   onDoubleTap: () => boardProvider.flag(Point(i, j)),
                                   onLongPress: () => boardProvider.flag(Point(i, j)),
                                   onTap: () => boardProvider.tap(Point(i, j)),
                                   child: Container(child: Center(child: Text(label)),
                                                    margin: EdgeInsets.all(3),
                                                    width:  30,
                                                    height: 30,
                                                    color: Colors.grey[200]));

        cells.add(cell);

      }

      Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: cells);
      rows.add(row);

    }

    return Column(children: rows);

  }

}
