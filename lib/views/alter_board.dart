import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper/providers/board.dart';


class AlterBoard extends StatefulWidget {
  @override
  _AlterBoardState createState() => _AlterBoardState();
}

class _AlterBoardState extends State<AlterBoard> {

  TextEditingController widthText = TextEditingController();
  TextEditingController heightText = TextEditingController();
  TextEditingController mineText = TextEditingController();

  get _padding => Padding(padding: EdgeInsets.all(10));

  @override
  Widget build(BuildContext context) {

    Board board = Provider.of<Board>(context);

    var widthField = Container(width: 70, child: TextField(controller: widthText, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "width")));

    var heightField = Container(width: 70, child: TextField(controller: heightText, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "height")));

    var mineField = Container(width: 70, child: TextField(controller: mineText, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "mines")));

    var setButton = MaterialButton(child: Text("set"), color: Colors.grey[300], onPressed: () {

      var width = int.tryParse(widthText.text.toString()) ?? 9;

      var height = int.tryParse(heightText.text.toString()) ?? 9;

      var mines = int.tryParse(mineText.text.toString()) ?? 10;

      board.changeBoard(width: width, height: height, mines: mines);
    });

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[_padding, widthField, _padding, heightField, _padding, mineField, _padding, setButton]);

  }
}
