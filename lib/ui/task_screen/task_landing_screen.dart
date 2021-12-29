import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_camera/controller/reports_controller.dart';
import 'package:in_app_camera/model/driver_report.dart';
import 'package:in_app_camera/ui/task_screen/scanner_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../main.dart';

class TaskLandingScreen extends StatefulWidget {

  final int index;

  const TaskLandingScreen({required this.index, Key? key}) : super(key: key);

  @override
  State<TaskLandingScreen> createState() => _TaskLandingScreenState();
}

class _TaskLandingScreenState extends State<TaskLandingScreen> {

  final _reportsController = Get.find<ReportsController>();
  late DriverReport reportObj;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Screen"),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child:   const Icon(Icons.forward),
          backgroundColor: Colors.blue,
          onPressed: () {

           var startingTime =  DateFormat(
                'E, MMM dd, yyyy  h:mm:ss a')
                .format(DateTime.now());

           var driverReport =  DriverReport(
               taskId:  mockTasks.elementAt(widget.index).taskId,
               driverId: '',
               barcode: reportsBox.get(mockTasks.elementAt(widget.index).taskId) != null ? reportObj.barcode : '',
               driverFullName: '',
               driverType: "Employee",
               isUploadedToServer: false,
               taskStatus: TaskStatus.inProgress.toString(),
               thumbnailImage: '',
               answerString: reportsBox.get(mockTasks.elementAt(widget.index).taskId) != null ? reportObj.answerString : '',
               startingTime: startingTime);

           _reportsController.reportsData.add(driverReport);

           reportsBox.put(
               mockTasks.elementAt(widget.index).taskId,
               driverReport
           );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  ScannerScreen(index: widget.index,)));
          }
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32,),
              const Text(
                'Use Google Maps inorder to reach the destination',
                textAlign: TextAlign.center,
              ),
              Text(
                'Tap to Navigate',
                style: Theme.of(context).textTheme.headline4,
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
                    await MapLauncher.showDirections(
                      destination: Coords(mockTasks.elementAt(0).destinationLat,mockTasks.elementAt(0).destinationLng),
                      origin: Coords(mockTasks.elementAt(0).originLat,mockTasks.elementAt(0).originLng),
                      mapType: MapType.google,
                    );
                  },
                  child: const Text(
                    'Open Google Maps',
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

  @override
  void initState() {

    if(reportsBox.get(mockTasks.elementAt(widget.index).taskId) != null){
        reportObj = reportsBox.get(mockTasks.elementAt(widget.index).taskId) as DriverReport;
      }
    super.initState();
  }
}
