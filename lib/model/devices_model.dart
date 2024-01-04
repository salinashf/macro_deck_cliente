import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class DevicesModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String host;

  @HiveField(2)
  final int port;

  const DevicesModel(this.id, this.host, this.port);
}
