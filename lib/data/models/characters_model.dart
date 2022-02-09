class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic> breakingBadSeasons;
  late String acotrName;
  late String apperedIn;
  late List<dynamic> betterCallSaulAppearanceSeasons;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeadOrAlive = json["status"];
    breakingBadSeasons = json["appearance"];
    acotrName = json["portrayed"];
    apperedIn = json["category"];
    betterCallSaulAppearanceSeasons = json["better_call_saul_appearance"];
  }
}
