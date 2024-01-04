import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macro_deck_client/model/buttons_grid_model.dart';
import 'package:macro_deck_client/repository/services_buttons.dart';
import 'package:macro_deck_client/util/color_hex.dart';
import 'package:macro_deck_client/util/string_ext.dart';

class GridButtonsScreen extends StatelessWidget {
  const GridButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: FutureBuilder<List<CellButton>?>(
          future: ServicesButtons.fetchGridBtnModel(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar datos'));
            } else {
              List<CellButton> data = snapshot.data ?? [];
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: data[index]
                            .backgroundColorHex
                            .toString()
                            .isNullOrEmpty()
                        ? Colors.black38
                        : ColorHex(data[index].backgroundColorHex.toString()),
                    // Color de fondo oscuro para la tarjeta
                    child: Center(
                        child: data[index].enable
                            ? Image.memory(
                                const Base64Decoder().convert(data[index]
                                        .iconBase64
                                        .toString()
                                        .isNullOrEmpty()
                                    ? data[index].labelBase64.toString()
                                    : data[index].iconBase64.toString()),
                                width: 40.0,
                                height: 40.0,
                                alignment: Alignment.center,
                                fit: BoxFit.fill)
                            : Text(data[index].positonList())),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
