import 'package:hive/hive.dart';

part 'match_details.g.dart';

 @HiveType(typeId: 0)
class MatchDetails extends HiveObject{
  @HiveField(0)
  final String team1;
   @HiveField(1)
  final String team2;
   @HiveField(2)
  late String imagePath1;
   @HiveField(3)
  late String imagePath2;
   @HiveField(4)
  final int time;
   @HiveField(5)
  final int date;
   @HiveField(6)
  final String category;
   @HiveField(7)
  final int gameno;
   @HiveField(8)
  final String typeofgame;
   @HiveField(9)
  final String stadium;
  MatchDetails( {
  required this.team1,
  required this.team2,
  required this.imagePath1,
  required this.imagePath2,
  required this.time,
  required this.date,
  required this.category,
  required this.gameno,
  required this.typeofgame,
  required this.stadium,});
}