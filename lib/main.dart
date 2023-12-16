import 'package:fansseathub/firebase_options.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:fansseathub/screen/screenSplash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive_flutter/hive_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');

  Hive.registerAdapter<MatchDetails>(MatchDetailsAdapter());

  await  Hive.openBox<MatchDetails>('matchdetails');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

