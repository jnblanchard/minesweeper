import 'package:flutter_web/material.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper/providers/board.dart';


/* TextFields not taking input on flutter-web
   https://github.com/flutter/flutter/issues/33011
*/

class AlterBoard extends StatefulWidget {
  @override
  _AlterBoardState createState() => _AlterBoardState();
}

class _AlterBoardState extends State<AlterBoard> {

  TextEditingController widthText = TextEditingController();
  TextEditingController heightText = TextEditingController();
  TextEditingController mineText = TextEditingController();

  get _padding => Padding(padding: EdgeInsets.all(10));

  Widget _field(TextEditingController controller, String placeholder) => Container(width: 70, child: TextField(maxLines: 2, controller: controller, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: placeholder)));

  @override
  Widget build(BuildContext context) {

    Board board = Provider.of<Board>(context);

    var widthField = _field(widthText, "width");

    var heightField = _field(heightText, "height");

    var mineField = _field(mineText, "mines");

    var setButton = MaterialButton(child: Text("set"), color: Colors.grey[300], onPressed: () {

      var width = int.tryParse(widthText.text.toString()) ?? 9;

      var height = int.tryParse(heightText.text.toString()) ?? 9;

      var mines = int.tryParse(mineText.text.toString()) ?? 10;

      board.changeBoard(width: width, height: height, mines: mines);

    });

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[_padding, widthField, _padding, heightField, _padding, mineField, _padding, setButton]);

  }

}
