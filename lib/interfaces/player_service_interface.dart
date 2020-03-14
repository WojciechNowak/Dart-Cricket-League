import 'package:dart_cricket/interfaces/service_interface.dart';
import 'package:dart_cricket/models/player.dart';

abstract class IPlayerService extends IService {
  List<Player> getPlayers();

  bool playerExists(Player player);

  Future<bool> savePlayer(Player player);

  Future<bool> removePlayer(Player player);
}
