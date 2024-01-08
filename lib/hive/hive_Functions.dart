import 'package:fansseathub/model/highlights.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:hive/hive.dart';

class Repository {
  static String boxName = "matchdetails";

  static Future<bool> addmatchdetails(
      MatchDetails model, String modelKey) async {
    try {
      final db = Hive.box<MatchDetails>(boxName);

      //model.id = int.parse(DateTime.now().millisecondsSinceEpoch.toString());

   
      await db.put(modelKey, model);

      print("Data added successfully");

      return true;
    } catch (e) {
      print("Error adding data: $e");
      return false;
    }
  }

  static Future<List<MatchDetails>> retrieveData() async {
    final db = Hive.box<MatchDetails>(boxName);
    return db.values.toList();
  }


  static Future<bool> updatematchdetails(
      MatchDetails model, String matchKey) async {
    try {
      final db = Hive.box<MatchDetails>(boxName);
      db.put(matchKey, model);
      print('Data updated successfully');
    } catch (e) {
      print('Error updating data: $e');
      return false;
    }
    return true;
  }

  static Future<void> deleteData(String matchKey) async {
    final db = await Hive.openBox<MatchDetails>(boxName);
    db.delete(matchKey);
  }
}
class VideoUtils {
  static String extractVideoId(String url) {
    final regExp = RegExp(
        r'(?<=watch\?v=|/videos/|embed\/|youtu.be\/|\/v\/|\/e\/|\?v=|&v=|\/videos\/|\/embed\/|youtu.be\/|\/v\/|\/e\/|watch\?v%3D|watch\?feature=player_embedded&v=|%2Fvideos%2F|embed&v=|%2Fv%2F|e&v=|v=|t=%2Fvideos%2F|t=%2Fv%2F|e&v=|http(?:s)?:\/\/www\.youtube\.com\/playlist\?list=|http(?:s)?:\/\/www\.youtube\.com\/user\/[^\/]+#watch\/|http(?:s)?:\/\/www\.youtube\.com\/c\/[^\/]+\/[^\/]+#watch\/|http(?:s)?:\/\/www\.youtube\.com\/user\/[^\/]+\/videos\/|http(?:s)?:\/\/www\.youtube\.com\/u\/[^\/]+\/[^\/]+#watch\/|http(?:s)?:\/\/youtu\.be\/)([^"&?\/\s]{11})');
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }
  // Future<List<Highlights>> getYoutubeVideos() async {
  //   final box = await Hive.openBox<Highlights>('highlights');
  //   return box.values.toList();
  // }
}