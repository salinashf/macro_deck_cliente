class ConfigGridModel {
  String? method;
  int? rows;
  int? columns;
  int? buttonSpacing;
  int? buttonRadius;
  bool? buttonBackground;
  double? brightness;
  bool? autoConnect;
  String? wakeLock;
  bool? supportButtonReleaseLongPress;

  ConfigGridModel(
      {this.method,
      this.rows,
      this.columns,
      this.buttonSpacing,
      this.buttonRadius,
      this.buttonBackground,
      this.brightness,
      this.autoConnect,
      this.wakeLock,
      this.supportButtonReleaseLongPress});

  ConfigGridModel.fromJson(Map<String, dynamic> json) {
    method = json['Method'];
    rows = json['Rows'];
    columns = json['Columns'];
    buttonSpacing = json['ButtonSpacing'];
    buttonRadius = json['ButtonRadius'];
    buttonBackground = json['ButtonBackground'];
    brightness = json['Brightness'];
    autoConnect = json['AutoConnect'];
    wakeLock = json['WakeLock'];
    supportButtonReleaseLongPress = json['SupportButtonReleaseLongPress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Method'] = method;
    data['Rows'] = rows;
    data['Columns'] = columns;
    data['ButtonSpacing'] = buttonSpacing;
    data['ButtonRadius'] = buttonRadius;
    data['ButtonBackground'] = buttonBackground;
    data['Brightness'] = brightness;
    data['AutoConnect'] = autoConnect;
    data['WakeLock'] = wakeLock;
    data['SupportButtonReleaseLongPress'] = supportButtonReleaseLongPress;
    return data;
  }
}
