import 'dart:math';

import 'package:macro_deck_client/util/constants.dart';

extension RndCtrl on Random {
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => charClientID.codeUnitAt(nextInt(length))));
}
