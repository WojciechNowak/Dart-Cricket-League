import 'package:dart_cricket/dto/player.dart';
import 'package:flutter/material.dart';

class AddPlayerModal {
  String _playerName;
  final _formKey = GlobalKey<FormState>();
  List<String> _playerNames;

  AddPlayerModal(List<String> playerNames) {
    _playerNames = playerNames.map((name) => name.toLowerCase()).toList();
  }

  Widget _createForm() {
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              new TextFormField(
                autofocus: true,
                decoration: new InputDecoration(labelText: 'Player name'),
                onChanged: (value) {
                  _playerName = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Player name can't be empty";
                  } else if (_playerNames.contains(_playerName.toLowerCase())) {
                    return 'Player already exists';
                  }
                  return null;
                },
              )
            ]
        )
    );
  }

  Widget showModal(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter player name'),
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: _createForm()
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.of(context).pop(Player.withName(_playerName));
            }
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}