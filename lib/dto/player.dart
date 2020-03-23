class Player {
  int id;
  String nickname;

  Player.withName(this.nickname) : id = 0;
  Player(this.id, this.nickname);
}