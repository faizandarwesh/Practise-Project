import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/controller/reports_controller.dart';
import 'package:in_app_camera/model/task_model.dart';
import 'package:in_app_camera/ui/login/login_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'model/driver_report.dart';
import 'model/task_model.dart';

late List<CameraDescription> cameras;
late Box reportsBox;
var mockData = <DriverReport>[];
var mockTasks = <TaskModel>[];
late String filePath;

void main() async {
  //Inorder to ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  //Inorder to prevent screen orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //Inorder to get available Cameras
  cameras = await availableCameras();

  /*//Initialize mock Task Model List
  AppConstants().taskModelList = [AppConstants().taskModel1,AppConstants().taskModel2,AppConstants().taskModel3];*/

  //To get reference of the application package folder
  final document = await getApplicationDocumentsDirectory();

  Hive.init(document.path);

  //Registering Hive adapters
  Hive.registerAdapter<DriverReport>(DriverReportAdapter());
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());

  //Initialize Hive boxes
  await Hive.openBox<DriverReport>(AppConstants.reportsBox);
  await Hive.openBox<TaskModel>(AppConstants.taskBox);

  //Register Getx Controller for Driver Report
  Get.put(ReportsController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter In App Camera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

