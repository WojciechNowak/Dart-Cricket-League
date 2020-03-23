import 'package:dart_cricket/database/model/player.dart';
import 'package:dart_cricket/interfaces/db/db_executor_interface.dart';
import 'package:dart_cricket/interfaces/player_service_interface.dart';
import 'package:dart_cricket/dto/player.dart';
import 'package:dart_cricket/interfaces/storage_service_interface.dart';
import 'package:injector/injector.dart';

class PlayerService implements IPlayerService {
  final _playerStorage = Injector.appInstance.getDependency<IStorageService>().getRepository<PlayerModel>();

  @override
  Future<bool> initialize() async {
    return Future.value(true);
  }

  @override
  Future<bool> shutdown() async {
    return Future.value(true);
  }

  Future<List<Player>> getPlayers() async {
    final List<PlayerModel> result = await _playerStorage.fetchAll(() => PlayerModel());
    return result?.map((p) {
      final map = p.toMap();
      return Player(p.id(), map[PlayerModel.columnName]);
    })?.toList();
  }

  @override
  Future<bool> savePlayer(Player player) async {
    final playerModel = PlayerModel();
    playerModel.fromMap({
      PlayerModel.columnName: player.nickname
    });
    var res = await _playerStorage.insert(playerModel);
    if (res.item1) {
      player.id = res.item2;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> removePlayer(Player player) {
    final playerModel = PlayerModel();
    playerModel.fromMap({
      PlayerModel.columnId: player.id
    });
    return _playerStorage.delete(playerModel);
  }

  @override
  Future<bool> playerExists(Player player) async {
    var result = await _playerStorage.fetchBy(() => PlayerModel(), QueryLimiter(fields: '${PlayerModel.columnName} = ?', values: [player.nickname]));
    return result.length > 0 ?? false;
  }
}