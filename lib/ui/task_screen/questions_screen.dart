import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/controller/reports_controller.dart';
import 'package:in_app_camera/model/driver_report.dart';
import 'package:in_app_camera/ui/custom_camera/camera_landing_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../main.dart';

class QuestionsScreen extends StatefulWidget {
  final int index;

  const QuestionsScreen({required this.index, Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {


  final _reportsController = Get.find<ReportsController>();
  late DriverReport reportObj;

  String _dropDownValue = 'Quarter full';


  @override
  void initState() {
    _reportsController.reportsData.elementAt(0).answerString = _dropDownValue;
    Box reportsBox = Hive.box<DriverReport>(AppConstants.reportsBox);
    if(reportsBox.get(mockTasks.elementAt(widget.index).taskId) != null) {
      reportObj = reportsBox.get(mockTasks.elementAt(widget.index).taskId) as DriverReport;

      setState(() {
        _dropDownValue =  reportObj.answerString.isEmpty ? "Quarter Full" : reportObj.answerString;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: (){

          reportsBox.put(
              mockTasks.elementAt(widget.index).taskId,
              DriverReport(
                  taskId: mockTasks.elementAt(widget.index).taskId,
                  driverId: '',
                  barcode:  _reportsController.reportsData.elementAt(0).barcode,
                  driverFullName: '',
                  driverType: "Employee",
                  isUploadedToServer: false,
                  taskStatus: TaskStatus.inProgress.toString(),
                  thumbnailImage: '',
                  answerString:  _dropDownValue,
                  startingTime:  _reportsController.reportsData.elementAt(0).startingTime));

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  CameraLandingScreen(index: widget.index,)));
        },
      ),
      appBar: AppBar(
        title: const Text("Questionnaire"),
      ),
      body: SafeArea(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("How much the bin is filled?",style: TextStyle(fontSize: 18),),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color:Colors.blue),
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(8)),
                child: DropdownButton<String>(
                  hint: Text(_dropDownValue),
                  items: <String>['Quarter full','Half full','full'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(
                          () {
                        _dropDownValue = value!;
                        _reportsController.reportsData.elementAt(0).answerString = _dropDownValue;
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16,),
          ],
        )),
      ),
    );
  }
}
