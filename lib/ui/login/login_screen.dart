
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_camera/service/network_status_service.dart';
import 'package:in_app_camera/ui/home/home_screen.dart';
import 'package:in_app_camera/utils/network_aware_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'test@yopmail.com';
    _passwordController.text = 'admin123';
    /*Box tasksBox = Hive.box<TaskModel>(AppConstants.taskBox);
    mockTasks.clear();
    mockTasks.addAll(tasksBox.values.toList() as List<TaskModel>);

    for (TaskModel item in mockTasks) {
     print("Status : ${item.taskStatus}");
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<NetworkStatus?>(
        initialData: null,
        create: (context) =>
        NetworkStatusService().networkStatusController.stream,
        child: NetworkAwareWidget(
          childWidget: SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/bg.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Column(
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.all_inclusive_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text('Enter your credentials',
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    enableSuggestions: true,
                                    autocorrect: false,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: 'Email',
                                        hintStyle: TextStyle(color: Colors.black38),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 20.0)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      /*suffixIcon: GestureDetector(
                                        onTap: () => _toggle(),
                                        child: SvgPicture.asset(eyeIcon,
                                            fit: BoxFit.scaleDown),
                                      ),*/
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color: Colors.black38),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 20.0)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text(
                                      'Log in',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: const Color(0xFF003764)),
                                    ),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(vertical: 8),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: const BorderSide(
                                                    color: Color(0xFF003764))))),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const HomeScreen()));
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
