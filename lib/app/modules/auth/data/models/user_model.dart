import 'package:alert_brains/app/modules/auth/data/models/games_level_model.dart';

class UserModel {
  late String uId;
  late String email;
  late String name;
  late String photoUrl;
  late int? age;
  late Gender? gender;
  late double? locationLat;
  late double? locationLong;
  late String? language;
  late String? country;
  late int coins;
  late GamesLevelModel gamesLevelModel;

  UserModel(
      {required this.uId,
      required this.email,
      required this.name,
      required this.photoUrl,
      this.age,
      this.gender,
      this.locationLat,
      this.locationLong,
      this.language,
      this.country,
      required this.coins,
      required this.gamesLevelModel});

  factory UserModel.fromJson(Map<dynamic, dynamic> data) {
    return UserModel(
        uId: data['uId'],
        email: data['email'],
        name: data['name'],
        photoUrl: data['photoUrl'],
        coins: data['coins'],
        age: data['age'],
        country: data['country'],
        gender: data['gender'],
        language: data['language'],
        locationLat: data['locationLat'],
        locationLong: data['locationLong'],
        gamesLevelModel: GamesLevelModel.fromJson(data['gamesLevelModel']));
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'age': age,
      'gender': gender,
      'locationLat': locationLat,
      'locationLong': locationLong,
      'language': language,
      'country': country,
      'coins': coins,
      'gamesLevelModel': gamesLevelModel.toMap()
    };
  }
}

enum Gender { Boy, Girl }
