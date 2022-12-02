import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trail/DashBoards/dash_board.dart';
import 'package:trail/login_page.dart';
import 'package:get/get.dart';
import 'package:trail/user_shared_preference.dart';

import 'DashBoards/CustomerDashboard.dart';



void main() async {
  await GetStorage.init();
  final userdata = GetStorage();
  runApp(Home());
  print(userdata.read('key_logStatus'));

}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final userdata=GetStorage();
  @override
  void initState(){
    super.initState();
    userdata.writeIfNull('key_logStatus', false);
    Future.delayed(Duration.zero,() async{
      checkiflogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child:  CircularProgressIndicator()
        ),
      ),
    );
  }
  void checkiflogged() async{
    userdata.read('key_logStatus')?
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CustomerDashboard())):Get.offAll(LoginPage());
  }
}

