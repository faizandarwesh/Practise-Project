import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/model/task_model.dart';
import 'package:in_app_camera/service/network_status_service.dart';
import 'package:in_app_camera/ui/task_screen/task_landing_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:in_app_camera/utils/network_aware_widget.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool statusCompleted = false;
  Box tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: StreamProvider<NetworkStatus?>(
        initialData: null,
        create: (context) =>
        NetworkStatusService().networkStatusController.stream,
        child: NetworkAwareWidget(
          childWidget: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "DRIVER ROUTES",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _createTaskItems(mockTasks.length),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  statusCompleted ? const Text(
                    "You have completed all the assigned tasks",
                   style: TextStyle(fontSize: 18),
                   textAlign: TextAlign.center,
                  ) : const Center(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {

   /* tasksBox.put("112233", AppConstants().taskModel1);
    tasksBox.put("223344", AppConstants().taskModel2);
    tasksBox.put("334455", AppConstants().taskModel3);

    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);*/

    mockTasks.clear();
    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);

    checkCompletedTasks();

    super.initState();
  }

  List<Widget> _createTaskItems(int index) {
    return List<Widget>.generate(index, (int index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Checkbox(
            value: true,
            activeColor: tasksBox.getAt(index).taskStatus ==
                    TaskStatus.completed.toString()
                ? Colors.lightGreen
                : tasksBox.getAt(index).taskStatus ==
                        TaskStatus.inProgress.toString()
                    ? Colors.deepOrange
                    : Colors.amberAccent,
            onChanged: (newValue) {},
          ),
          SizedBox(
            width: 250,
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
                  if (mockTasks.elementAt(index).taskStatus ==
                      TaskStatus.inProgress.toString()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskLandingScreen(
                                  index: index,
                                )));
                  } else if (mockTasks.elementAt(index).taskStatus ==
                      TaskStatus.completed.toString()) {
                    Get.snackbar(
                      'Task status : ${mockTasks.elementAt(index).taskStatus} ',
                      "You have completed this task successfully",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else if (mockTasks.elementAt(index).taskStatus ==
                      TaskStatus.pending.toString()) {
                    Get.snackbar(
                      'Task status : ${mockTasks.elementAt(index).taskStatus} ',
                      "You have to complete previously assign task inorder to proceed",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Text(
                  'TASK ${index + 1}',
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  bool checkCompletedTasks() {
    for (TaskModel item in mockTasks) {
      if (item.taskStatus != TaskStatus.completed.toString()) {
        statusCompleted = false;
        break;
      } else {
        statusCompleted = true;
      }
    }

    return statusCompleted;
  }
}
