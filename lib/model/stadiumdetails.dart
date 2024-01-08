import 'package:hive/hive.dart';
part 'stadiumdetails.g.dart';

@HiveType(typeId: 1)
class StadiumDetails {
  @HiveField(0)
  final String stadiumKey;
  @HiveField(1)
 late String imagePathstadium;
  @HiveField(2)
  final String stadiumname;
  @HiveField(3)
  final String stands1;
  @HiveField(4)
  final String ticketcharge1;
  @HiveField(5)
  final String stands2;
  @HiveField(6)
  final String ticketcharge2;
  @HiveField(7)
   final String stands3;
  @HiveField(8)
   final String ticketcharge3;
  @HiveField(9)
   final String stands4;
  @HiveField(10)
   final String ticketcharge4;
 @HiveField(11)
   final String standsac1;
  @HiveField(12)
   final String ticketchargeac1;
    @HiveField(13)
   final String standsac2;
  @HiveField(14)
   final String ticketchargeac2;




  StadiumDetails({
    required this.stadiumKey,
    required this.imagePathstadium,
    required this.stadiumname,
    required this.stands1,
    required this.ticketcharge1,
    required this.stands2,
    required this.ticketcharge2,
    required this.stands3,
    required this.ticketcharge3,
    required this.stands4,
    required this.ticketcharge4,
    required this.standsac1,
    required this.ticketchargeac1,
    required this.standsac2,
    required this.ticketchargeac2,

  });
}