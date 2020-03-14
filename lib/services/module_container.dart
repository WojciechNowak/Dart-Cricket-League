import 'package:injector/injector.dart';
import 'package:dart_cricket/interfaces/all_interfaces.dart';
import 'package:dart_cricket/services/player_service.dart';

class ModuleContainer {
  static final _injector = Injector.appInstance;
  static void configure() {
    _injector.registerSingleton<IPlayerService>((_) => PlayerService());
  }

  static Future initialize() async {
    await Future.wait([
      _injector.getDependency<IPlayerService>().initialize()
    ]);
  }
}