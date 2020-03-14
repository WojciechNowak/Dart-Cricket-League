import 'package:dart_cricket/interfaces/all_interfaces.dart';
import 'package:dart_cricket/widgets/add_player_modal.dart';
import 'package:flutter/material.dart';

import 'package:injector/injector.dart';
import 'package:dart_cricket/models/player.dart';

class StandardGamePlayers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StandardGamePlayersState();
}

class _StandardGamePlayersState extends State<StandardGamePlayers> {
  final _playerService = Injector.appInstance.getDependency<IPlayerService>();
  final _selectedPlayers = <Player>[];
  final _availablePlayers = <Player>[];

  Widget _buildPlayers() {
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
      )
    ]);
  }


  @override
  void initState() {
    _availablePlayers.addAll(_playerService.getPlayers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Choose players')),
        body: _buildPlayers(),
        floatingActionButton: FloatingActionButton(
          onPressed: () { _addNewPlayer(context); },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
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
            //TODO add modal with question for confirmation
            final res = await _playerService.removePlayer(player);
            if (res) {
              setState(() { isAvailable ? _availablePlayers.remove(player) : _selectedPlayers.remove(player); });
            } else {
              //TODO handle error
            }
          },
        ),
        title: Text(player.nickname));
  }

  void _addNewPlayer(BuildContext context) async {
    final newPlayer = await showDialog<Player>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddPlayerModal().showModal(context);
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
