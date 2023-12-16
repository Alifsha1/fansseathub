import 'package:hive/hive.dart';

part 'matchdetails.g.dart';

@HiveType(typeId: 0)
class MatchDetails {
  @HiveField(0)
  final String matchKey;
  @HiveField(1)
  final String team1;
  @HiveField(2)
  final String team2;
  @HiveField(3)
  late String imagePath1;
  @HiveField(4)
  late String imagePath2;
  @HiveField(5)
  final String time;
  @HiveField(6)
  final String date;
  @HiveField(7)
  final String category;
  @HiveField(8)
  final String gameno;
  @HiveField(9)
  final String typeofgame;
  @HiveField(10)
  final String stadium;
  MatchDetails({
    required this.matchKey,
    required this.team1,
    required this.team2,
    required this.imagePath1,
    required this.imagePath2,
    required this.time,
    required this.date,
    required this.category,
    required this.gameno,
    required this.typeofgame,
    required this.stadium,
  });
}
