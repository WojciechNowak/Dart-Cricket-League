import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  final String _pageName;

  PageNotFound(this._pageName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Page $_pageName not found :(')),
    );
  }
}