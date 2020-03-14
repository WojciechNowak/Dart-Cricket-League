import 'package:dart_cricket/interfaces/player_service_interface.dart';
import 'package:dart_cricket/models/player.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class AddPlayerModal {
  String _playerName;
  final _formKey = GlobalKey<FormState>();
  final _playerService = Injector.appInstance.getDependency<IPlayerService>();

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
                  } else if (_playerService.playerExists(Player(_playerName))) {
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
              Navigator.of(context).pop(Player(_playerName));
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