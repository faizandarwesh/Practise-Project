//flutter packages pub run build_runner build

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  TaskModel({
    required this.taskId,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.taskStatus,
  });

  @HiveField(0)
  int taskId;
  @HiveField(1)
  double originLat;
  @HiveField(2)
  double originLng;
  @HiveField(3)
  double destinationLat;
  @HiveField(4)
  double destinationLng;
  @HiveField(5)
  String taskStatus;
}


