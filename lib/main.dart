import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_deck_client/main_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await _initHive();
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MainApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox("login");
  await Hive.openBox("accounts");
}
