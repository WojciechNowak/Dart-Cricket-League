import 'package:flutter/material.dart';

class ConfirmationModal {
  final String _title;
  final String _text;

  ConfirmationModal(this._title, this._text);

  Widget showModal(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Center(child: Text(_text)),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
              Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}