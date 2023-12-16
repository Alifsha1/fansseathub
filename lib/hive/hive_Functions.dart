import 'package:fansseathub/model/matchdetails.dart';
import 'package:hive/hive.dart';

class Repository {
  static String boxName = "matchdetails";

  static Future<bool> addmatchdetails(MatchDetails model, String modelKey) async {
    try {
      final db = Hive.box<MatchDetails>(boxName);

      //model.id = int.parse(DateTime.now().millisecondsSinceEpoch.toString());

      print('model key = ${model.matchKey}');
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

  // static Future<bool> updatematchdetails(MatchDetails model) async {
  //   try {
  //     print('data updated');
  //     final db = await Hive.openBox<MatchDetails>(boxName);
  //     db.put(model.id, model);
  //   } catch (e) {
  //     return false;
  //   }
  //   return true;
  // }
  static Future<bool> updatematchdetails(MatchDetails model, String matchKey) async {
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
