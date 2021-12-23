import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_camera/ui/custom_camera/camera_landing_screen.dart';
import 'package:in_app_camera/ui/task_screen/questions_screen.dart';
import 'package:in_app_camera/ui/task_screen/scanner_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:in_app_camera/utils/helper_functions.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:get/get.dart';
import '../../main.dart';

class TaskLandingScreen extends StatelessWidget {
  const TaskLandingScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Screen"),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child:  const Icon(Icons.check),
          backgroundColor: Colors.blue,
          onPressed: () async{
            if(mockTasks.elementAt(0).taskStatus == TaskStatus.completed.toString()){
              await HelperFunctions.checkInternetConnection().then((value) {
                if (value) {
                  Get.snackbar(
                    'Task status',
                    "Sent to server",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {

                }
              });
              Get.snackbar(
                'Task status',
                "Save to local storage",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
            else if(mockTasks.elementAt(0).taskStatus == TaskStatus.inProgress.toString()){
              Get.snackbar(
                'Task status',
                "In Progress",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
            else if(mockTasks.elementAt(0).taskStatus == TaskStatus.pending.toString()){
              Get.snackbar(
                'Task status',
                "Pending",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
            else {
              Get.snackbar(
                'Task status',
                "Inside Else",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  onPressed: () async{
                    await MapLauncher.showDirections(
                      destination: Coords(mockTasks.elementAt(0).destinationLat,mockTasks.elementAt(0).destinationLng),
                      origin: Coords(mockTasks.elementAt(0).originLat,mockTasks.elementAt(0).originLng),
                      mapType: MapType.google,
                    );
                  },
                  child: const Text(
                    'Navigate to Google Maps',
                  ),
                ),
              ),
              const SizedBox(height: 16,),
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
                            builder: (context) => const ScannerScreen()));
                  },
                  child: const Text(
                    'Scan QR/Barcode Code',
                  ),
                ),
              ),
              const SizedBox(height: 16,),
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
                  onPressed: () async{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionsScreen()));
                  },
                  child: const Text(
                    'Questionnaire',
                  ),
                ),
              ),
              const SizedBox(height: 16,),
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
                            builder: (context) => const CameraLandingScreen()));
                  },
                  child: const Text(
                    'Take Bin Picture',
                  ),
                ),
              ),
              const SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
