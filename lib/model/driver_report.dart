

//flutter packages pub run build_runner build

import 'package:hive/hive.dart';

part 'driver_report.g.dart';

@HiveType(typeId: 0)
class DriverReport extends HiveObject {
  DriverReport({
    required this.taskId,
    required this.driverFullName,
    required this.driverId,
    required this.driverType,
    required this.barcode,
    required this.thumbnailImage,
    required this.taskStatus,
    required this.isUploadedToServer,
  });

  @HiveField(0)
  int taskId;
  @HiveField(1)
  String driverFullName;
  @HiveField(2)
  String driverId;
  @HiveField(3)
  String driverType;
  @HiveField(4)
  String barcode;
  @HiveField(5)
  String thumbnailImage;
  @HiveField(6)
  String taskStatus;
  @HiveField(7)
  bool isUploadedToServer;
}
