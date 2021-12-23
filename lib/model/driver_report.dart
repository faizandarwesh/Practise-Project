

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
    required this.startingTime,
    required this.barcode,
    required this.thumbnailImage,
    required this.taskStatus,
    required this.answerString,
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
  String startingTime;
  @HiveField(5)
  String barcode;
  @HiveField(6)
  String thumbnailImage;
  @HiveField(7)
  String taskStatus;
  @HiveField(8)
  String answerString;
  @HiveField(9)
  bool isUploadedToServer;
}
