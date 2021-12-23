import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  String _dropDownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              width: 250,
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
                },
                child: const Text(
                  'Submit',
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
