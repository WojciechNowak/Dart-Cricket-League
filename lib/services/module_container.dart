import 'package:injector/injector.dart';
import 'package:dart_cricket/interfaces/all_interfaces.dart';
import 'package:dart_cricket/services/player_service.dart';
import 'package:dart_cricket/services/storage_service.dart';

class ModuleContainer {
  static final _injector = Injector.appInstance;
  static void configure() {
    _injector.registerSingleton<IPlayerService>((_) => PlayerService());
    _injector.registerSingleton<IStorageService>((_) => StorageService());
  }

  static Future initialize() async {
    await _injector.getDependency<IStorageService>().initialize();
    await Future.wait([
      _injector.getDependency<IPlayerService>().initialize(),
    ]);
  }

  static Future shutdown() async {
    await Future.wait([
      _injector.getDependency<IPlayerService>().shutdown(),
    ]);
    await _injector.getDependency<IStorageService>().shutdown();
  }
}