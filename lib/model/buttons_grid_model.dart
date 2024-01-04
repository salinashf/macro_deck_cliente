class ButtonsGridModel {
  String? method;
  List<CellButton>? buttons;
  ButtonsGridModel({this.method, this.buttons});
  ButtonsGridModel.fromJson(Map<String, dynamic> json) {
    method = json['Method'];
    if (json['Buttons'] != null) {
      buttons = <CellButton>[];
      json['Buttons'].forEach((v) {
        buttons!.add(CellButton.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Method'] = method;
    if (buttons != null) {
      data['Buttons'] = buttons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CellButton {
  String? iconBase64;
  int? positionX;
  int? positionY;
  String? labelBase64;
  String? backgroundColorHex;
  bool enable = true;

  CellButton(
      {this.iconBase64,
      this.positionX,
      this.positionY,
      this.labelBase64,
      this.backgroundColorHex,
      this.enable = true});

  CellButton.fromJson(Map<String, dynamic> json) {
    iconBase64 = json['IconBase64'];
    positionX = json['Position_X'];
    positionY = json['Position_Y'];
    labelBase64 = json['LabelBase64'];
    backgroundColorHex = json['BackgroundColorHex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IconBase64'] = iconBase64;
    data['Position_X'] = positionX;
    data['Position_Y'] = positionY;
    data['LabelBase64'] = labelBase64;
    data['BackgroundColorHex'] = backgroundColorHex;
    return data;
  }

  int positonABSYX() {
    return int.tryParse('$positionY$positionX')!;
  }

  int positonABSXY() {
    return int.tryParse('$positionX$positionY')!;
  }

  String positonAbs() {
    return '( $positionX , $positionY )';
  }

  String positonList() {
    return '${positionX}_$positionY';
  }
}
