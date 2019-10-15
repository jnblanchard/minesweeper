import 'package:flutter/material.dart';
import 'package:minesweeper/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper/providers/board.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(Minesweeper());
}

class Minesweeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(providers: [ChangeNotifierProvider(builder: (_) => Board())],
                                                                    child: MaterialApp(home: HomePage()));
}