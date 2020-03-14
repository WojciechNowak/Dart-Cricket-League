import 'package:flutter/material.dart';
import 'package:dart_cricket/consts/routes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FractionallySizedBox(
            widthFactor: 70,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    child: RaisedButton(
                      child: Text(
                        'New game',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () => Navigator.pushNamed(context, standardGamePlayers)
                    ),
                  ),
                ]
            )
        )
    );
  }
}