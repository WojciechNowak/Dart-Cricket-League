import 'package:dart_cricket/interfaces/service_interface.dart';
import 'package:dart_cricket/dto/player.dart';

abstract class IPlayerService extends IService {
  Future<List<Player>> getPlayers();

  Future<bool> playerExists(Player player);

  Future<bool> savePlayer(Player player);

  Future<bool> removePlayer(Player player);
}
