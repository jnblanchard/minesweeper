import 'package:flutter_web/material.dart';
import 'package:minesweeper/providers/board.dart';
import 'package:provider/provider.dart';

class TopBoard extends StatefulWidget {
  @override
  _TopBoardState createState() => _TopBoardState();
}

class _TopBoardState extends State<TopBoard> {
  @override
  Widget build(BuildContext context) {

    Board boardProvider = Provider.of<Board>(context);

    var flagsLeft = boardProvider.mines - boardProvider.flagLocations.length;

    var scoreLabel = Text(flagsLeft.toString());

    var boardStateLabel = boardProvider.isBlownUp ? Text("XD") : Text("=D");
    var boardStateButton = MaterialButton(onPressed: () => boardProvider.changeBoard(),
                                          child: boardStateLabel);

    var timeLabel = Text(boardProvider.secondsGoneBy.toString());

    var row = Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[scoreLabel, boardStateButton, timeLabel]);

    return row;

  }

}
