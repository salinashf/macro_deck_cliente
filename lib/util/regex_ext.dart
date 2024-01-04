import 'package:macro_deck_client/util/constants.dart';

extension RegExpCtrl on RegExp {
  bool isIPValida() => hasMatch(validateIP);
}
