import 'package:flutter/material.dart';
import 'package:dart_cricket/consts/routes.dart';
import 'package:dart_cricket/pages/home.dart';
import 'package:dart_cricket/pages/standard_game_players.dart';
import 'package:dart_cricket/pages/page_not_found.dart';

class Router {
  static String initialRoute() => homeRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => Home());
      case standardGamePlayers:
        return MaterialPageRoute(builder: (context) => StandardGamePlayers());
      case teamGamePlayers:
        return null;
      default:
        return MaterialPageRoute( builder: (context) => PageNotFound(settings.name));
    }
  }
}
