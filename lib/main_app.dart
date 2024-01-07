import 'package:flutter/material.dart';
import 'package:macro_deck_client/theme/palett.dart';
import 'package:macro_deck_client/widget/screen/device_connect.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      theme: lightTheme,
      home: const DeviceConnect(),
    );
  }
}
