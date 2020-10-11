import 'package:dart_cricket/domain/game_data.dart';
import 'package:dart_cricket/dto/player.dart';
import 'package:flutter/material.dart';

class StandardGame extends StatefulWidget {
  final GameData _gameData;

  StandardGame(this._gameData);

  @override
  State<StatefulWidget> createState() => _StandardGame();
}

class _StandardGame extends State<StandardGame> {
  double _scoreBoardOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Game')),
        body: _scoreboard
    );
  }

  Widget get _scoreboard => Opacity(
    opacity: _scoreBoardOpacity,
    child: Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          child: Table(
            border: TableBorder.all(),
            children: _createScoreTable(),
          ),
        ),
      ),
    ),
  );

  List<TableRow> _createScoreTable() {
    return widget._gameData.numbers.map((num) {
      return TableRow(
        children: widget._gameData.players.map((p) {
          return TableCell(
            child: Text(p.nickname)
          );
        }).toList()
      );
    }).toList();
  }

  Widget _getScoreFiled(int )

}