import 'package:in_app_camera/model/task_model.dart';

enum TaskStatus {pending,inProgress,completed }

enum DriverType {contract,employee }

class AppConstants {

  static const String reportsBox = "reports";
  static const String taskBox = "tasks";

  //Genetech Solutions to Dolmen Tariq Road
  final TaskModel taskModel1 = TaskModel(
      taskId: 112233,
      originLat: 24.8793411,
      originLng: 67.0570163,
      destinationLat: 24.8766284,
      destinationLng: 67.0606163,
      taskStatus: TaskStatus.inProgress.toString());

  //Danish Motors to Cocochan
  final TaskModel taskModel2 = TaskModel(
      taskId: 223344,
      originLat: 24.8788558,
      originLng: 67.0574807,
      destinationLat: 24.8661457,
      destinationLng: 67.0756145,
      taskStatus: TaskStatus.pending.toString());

  //Genetech Solutions to Darul Sukoon
  final TaskModel taskModel3 = TaskModel(
      taskId: 334455,
      originLat: 24.8793411,
      originLng: 67.0570163,
      destinationLat: 24.8815172,
      destinationLng: 67.0531295,
      taskStatus: TaskStatus.pending.toString());

// List<TaskModel> taskModelList = [];
}
