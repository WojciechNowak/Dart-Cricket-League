import 'package:dart_cricket/consts/routes.dart';
import 'package:dart_cricket/domain/game_data.dart';
import 'package:dart_cricket/interfaces/all_interfaces.dart';
import 'package:dart_cricket/widgets/add_player_modal.dart';
import 'package:dart_cricket/widgets/confirmation_modal.dart';
import 'package:flutter/material.dart';

import 'package:injector/injector.dart';
import 'package:dart_cricket/dto/player.dart';

class StandardGamePlayers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StandardGamePlayersState();
}

class _StandardGamePlayersState extends State<StandardGamePlayers> {
  final _playerService = Injector.appInstance.getDependency<IPlayerService>();
  final _selectedPlayers = <Player>[];
  final _availablePlayers = <Player>[];
  bool _isLoaded = false;

  Function _startGame() {
    return _selectedPlayers.length >= 2 ? () => Navigator.pushNamed(context, startStandardGame, arguments: GameData(_selectedPlayers, [20,19,18,17,16,15])) : null;
  }

  Widget _playersFetched(BuildContext context) {
    return Column(children: [
      Center(child: Text('Selected players')),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _selectedPlayers.length,
              itemBuilder: (context, index) {
                return _buildPlayerRow(_selectedPlayers[index]);
              })),
      Center(child: Text('Available players')),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _availablePlayers.length,
              itemBuilder: (context, index) {
                return _buildPlayerRow(_availablePlayers[index]);
              })
      ),
      Center( child: ButtonTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
          child: RaisedButton(
              child: Text(
                'Start',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            onPressed: _startGame(),
          ),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
        future: _isLoaded ? Future.value(_availablePlayers) : _playerService.getPlayers(),
        builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
          Widget child = _waiting();
          if (snapshot.hasData) {
            if (!_isLoaded) {
              _availablePlayers.addAll(snapshot.data);
            }
            child = _playersFetched(context);
            _isLoaded = true;
          } else if (snapshot.hasError) {
            //TODO throw and handle error
          }
          return Scaffold(
              appBar: AppBar(title: Text('Choose players')),
              body: child,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _addNewPlayer(context);
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
              )
          );
        });
  }

  Widget _waiting() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ],
      )
    );
  }

  Widget _buildPlayerRow(Player player) {
    var isAvailable = _availablePlayers.contains(player);
    return ListTile(
        onTap: () {
          if (isAvailable) {
            setState(() {
              _availablePlayers.remove(player);
              _selectedPlayers.add(player);
            });
          } else {
            setState(() {
              _availablePlayers.add(player);
              _selectedPlayers.remove(player);
            });
          }
        },
        trailing: IconButton(
          icon: Icon(
            Icons.remove,
            color: Colors.grey[300],
          ),
          onPressed: () async {
            await _removePlayer(context, isAvailable ? _availablePlayers : _selectedPlayers, player );
          },
        ),
        title: Text(player.nickname));
  }

  Future<void> _removePlayer(BuildContext context, List<Player> playersList, Player player) async {
    final bool remove = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmationModal('Delete?', 'Do you really want to delete player: ${player.nickname}').showModal(context);
      }
    );

    if (remove) {
      _playerService.removePlayer(player);
      playersList.remove(player);

      setState(() {});
    }
  }

  void _addNewPlayer(BuildContext context) async {
    final List<String> allPlayers = [..._selectedPlayers, ..._availablePlayers].map((p) => p.nickname).toList();
    final newPlayer = await showDialog<Player>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddPlayerModal(allPlayers).showModal(context);
      },
    );
    
    if (newPlayer != null) {
      final ret = await _playerService.savePlayer(newPlayer);
      if (ret) {
        setState(() {
          _availablePlayers.add(newPlayer);
        });
      } else {
        //TODO handle error
      }
    }
  }
}
