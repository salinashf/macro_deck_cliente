import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:macro_deck_client/widget/screen/device_connect.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff1145a4),
          primaryContainer: Color(0xff9fb4da),
          secondary: Color(0xffb61d1d),
          secondaryContainer: Color(0xffe1a4a4),
          tertiary: Color(0xff376bca),
          tertiaryContainer: Color(0xffcfdbf2),
          appBarColor: Color(0xffcfdbf2),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        colors: FlexSchemeColor(
          primary: Colors.grey.shade900,
          primaryContainer: const Color(0xff9fb4da),
          secondary: Colors.grey.shade100,
          secondaryContainer: const Color(0xffe1a4a4),
          tertiary: const Color(0xff376bca),
          tertiaryContainer: const Color(0xffcfdbf2),
          appBarColor: const Color(0xffcfdbf2),
          error: const Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
      ),
      home: const DeviceConnect(),
    );
  }
}
