class Move {
  String? characterName;
  String? moveName;
  String? image;

  Move({this.characterName, this.moveName, this.image});

  Move.fromJson(Map<String, dynamic> json) {
    characterName = json['character_name'];
    moveName = json['move_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['character_name'] = this.characterName;
    data['move_name'] = this.moveName;
    data['image'] = this.image;
    return data;
  }
}
