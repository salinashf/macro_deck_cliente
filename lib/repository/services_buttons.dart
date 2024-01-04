import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:macro_deck_client/model/buttons_grid_model.dart';

class ServicesButtons {
  static Future<List<CellButton>?> fetchGridBtnModel(
      BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    final String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/step4 GET_BUTTONS.json");
    List<CellButton>? list = parseBtnModel(data, 10, 5);
    return list;
  }

  static List<CellButton>? parseBtnModel(
      String responseBody, int rows, int cols) {
    //final Map<String, dynamic> parsed = json.decode(responseBody);
    final parsed = json.decode(responseBody);
    final ButtonsGridModel btnModel = ButtonsGridModel.fromJson(parsed);
    List<CellButton>? lstButton = btnModel.buttons;
    lstButton?.sort((a, b) => a.positonABSXY().compareTo(b.positonABSXY()));
    List<String> listCurrent = [];
    lstButton?.asMap().forEach((key, value) {
      listCurrent.add(value.positonList());
    });
    List<String> listMaster = Iterable<String>.generate(
        rows * cols, (index) => '${index ~/ cols}_${index % cols}').toList();
    listMaster.removeWhere((item) => listCurrent.contains(item));
    for (var item in listMaster) {
      lstButton?.add(CellButton(
          iconBase64: '',
          positionX: int.parse(item.split('_')[0]),
          positionY: int.parse(item.split('_')[1]),
          labelBase64: '',
          backgroundColorHex: '',
          enable: false));
    }
    lstButton?.sort((a, b) => a.positonABSYX().compareTo(b.positonABSYX()));
    return lstButton;
  }
}
