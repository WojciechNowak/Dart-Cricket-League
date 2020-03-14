import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String nickname;

  Player(this.nickname);

  @override
  List<Object> get props => [nickname.toLowerCase()];

  @override
  bool get stringify => true;
}