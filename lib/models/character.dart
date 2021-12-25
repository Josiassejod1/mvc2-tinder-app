class Character {
  String? name;
  String? headShot;
  String? universe;

  Character({this.name, this.headShot, this.universe});

  Character.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    headShot = json['head_shot'];
    universe = json['universe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['head_shot'] = this.headShot;
    data['universe'] = this.universe;
    return data;
  }
}
