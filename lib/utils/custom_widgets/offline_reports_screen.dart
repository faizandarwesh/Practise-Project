import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/model/task_model.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'dart:io';
import '../../main.dart';
import '../../model/driver_report.dart';

class OfflineReportsScreen extends StatefulWidget {
  const OfflineReportsScreen({Key? key}) : super(key: key);

  @override
  _OfflineReportsScreenState createState() => _OfflineReportsScreenState();
}

class _OfflineReportsScreenState extends State<OfflineReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Offline Reports'),
        ),
        body: SafeArea(
          child: mockData.isNotEmpty
              ? ListView.builder(
                  itemCount: mockData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          child:
                              Image.file(File(mockData[index].thumbnailImage),fit: BoxFit.cover,),
                        ),
                        title: Text(mockData[index].taskStatus + mockData[index].answerString + mockData[index].startingTime + mockData[index].isUploadedToServer.toString()),
                        subtitle: Text(mockData[index].barcode));
                  },
                )
              : Center(
                  child: Text(
                    "No records found in local DB",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
        ));
  }

  @override
  void initState() {
    getDataFromLocalDb();
    super.initState();
  }

  void getDataFromLocalDb() {
    reportsBox = Hive.box<DriverReport>(AppConstants.reportsBox);
    /*tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);
    for(TaskModel item in mockTasks){
      print("Mock task : $item");
    }*/
    mockData.clear();
    mockData.addAll(reportsBox.values.toList() as List<DriverReport>);
  }
}
