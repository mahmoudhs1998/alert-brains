class GameDetailsModel {
  late int level;
  late int trials;

  GameDetailsModel({required this.level, required this.trials});

  factory GameDetailsModel.fromJson(Map<dynamic, dynamic> data) {
    return GameDetailsModel(level: data['level'], trials: data['trials']);
  }

  Map<String, dynamic> toMap() {
    return {'level': level, 'trials': trials};
  }
}
