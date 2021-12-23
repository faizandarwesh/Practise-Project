import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/model/task_model.dart';
import 'package:in_app_camera/ui/task_screen/task_landing_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("DRIVER ROUTES",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
              const SizedBox(height: 16,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _createTaskItems(
                    3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
   /*  var random = Random();
    tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    tasksBox.put("${random.nextInt(1000)}",AppConstants().taskModel1);
    tasksBox.put("${random.nextInt(1000)}",AppConstants().taskModel2);
    tasksBox.put("${random.nextInt(1000)}",AppConstants().taskModel3);

    // tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);*/

    tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    mockTasks.clear();
    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);
    super.initState();
  }

  List<Widget> _createTaskItems(int index) {
    return List<Widget>.generate(index, (int index) {
      return SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 13),
              ),
              textStyle: MaterialStateProperty.all(
                GoogleFonts.poppins(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onPressed: () {
             if( mockTasks.elementAt(index).taskStatus.toString() == TaskStatus.inProgress.toString()){
               Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => TaskLandingScreen(index: index,)));
             }
             else if(mockTasks.elementAt(index).taskStatus.toString() == TaskStatus.completed.toString()){
               Get.snackbar(
                 'Task status : ${mockTasks.elementAt(index).taskStatus.toString()} ',
                 "You have completed this task successfully",
                 snackPosition: SnackPosition.BOTTOM,
               );
             }
             else if(mockTasks.elementAt(index).taskStatus.toString() == TaskStatus.pending.toString()){
               Get.snackbar(
                 'Task status : ${mockTasks.elementAt(index).taskStatus.toString()} ',
                 "You have to complete previously assign task inorder to proceed",
                 snackPosition: SnackPosition.BOTTOM,
               );
             }
            },
            child:  Text(
              'TASK ${index + 1}',
            ),
          ),
        ),
      );
    });
  }
}
