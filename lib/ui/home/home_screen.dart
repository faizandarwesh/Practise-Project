import 'dart:math';

import 'package:flutter/material.dart';
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
              const Text("DRIVER ROUTES",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              const SizedBox(height: 32,),
              SizedBox(
                width: 300,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TaskLandingScreen()));
                  },
                  child: const Text(
                    'LOCATION 1',
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: 300,
                child: IgnorePointer(
                  ignoring: true,
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

                    },
                    child: const Text(
                      'LOCATION 2',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: 300,
                child: IgnorePointer(
                  ignoring: true,
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

                    },
                    child: const Text(
                      'LOCATION 3',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
     var random = Random();
    tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    tasksBox.put("${random.nextInt(1000)}",AppConstants().taskModel1);
    tasksBox.put("${random.nextInt(1000)}",AppConstants().taskModel2);
    tasksBox.put("${random.nextInt(1000)}",AppConstants().taskModel3);

    // tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);
    super.initState();
  }

  List<Widget> _createTaskItems(int index, ThemeData themeContext) {
    return List<Widget>.generate(index, (int index) {
      return SizedBox(
        width: 300,
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TaskLandingScreen()));
          },
          child:  Text(
            'TASK ${index + 1}',
          ),
        ),
      );
    });
  }
}
