import 'package:dart_cricket/interfaces/player_service_interface.dart';
import 'package:dart_cricket/models/player.dart';

class PlayerService implements IPlayerService {
  List<Player> _playerList = new List<Player>();

  @override
  Future<bool> initialize() async {
    var result = await Future.delayed(Duration(seconds: 1), () {
      return [
        Player('DeJones'),
        Player('Gutek'),
        Player('Stary'),
        Player('Biniu')
      ];
    });

    _playerList = new List<Player>.from(result);

    return Future.value(true);
  }

  @override
  Future<bool> shutdown() async {
    return Future.value(true);
  }

  List<Player> getPlayers() {
    return _playerList;
  }

  @override
  Future<bool> savePlayer(Player player) {
    _playerList.add(player);
    //TODO save player to file
    return Future.value(true);
  }

  @override
  Future<bool> removePlayer(Player player) {
    //TODO remove player from file
    _playerList.remove(player);
    return Future.value(true);
  }

  @override
  bool playerExists(Player player) {
    return _playerList.contains(player);
  }
}