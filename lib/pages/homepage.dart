import 'package:flutter_web/material.dart';
import 'package:minesweeper/views/top_board.dart';
import 'package:minesweeper/views/game_board.dart';
import 'package:minesweeper/views/alter_board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) => Scaffold(body: Column(children: <Widget>[TopBoard(), GameBoard(), /*AlterBoard()*/]));
}

