import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trail/DashBoards/CustomerDashboard.dart';
import 'package:trail/signup_page.dart';
import 'package:http/http.dart' as http;

import 'package:get_storage/get_storage.dart';

const logo = 'assets/logo.svg';

class User {
  String email;
  String password;
  User(this.email, this.password);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  Future<void> verifyUser(String email, String password) async {
    try {
      Map<String, String> customHeaders = {"content-type": "application/json"};
      final res = await http.post(
          Uri.parse("https://ticketeasy.tk/api/v1/loginUser"),
          headers: customHeaders,
          body: json.encode({'email': user.email, 'password': user.password}));

      final userdata = GetStorage();

      if (res.statusCode == 200) {
        final data = await json.decode(res.body) as Map;
        print(data);
        if (data["user"]) {
          // final prefs = await SharedPreferences.getInstance();
          // print(data["username"]);
          // final myString = prefs.setString('__key', data["username"]);
          SnackBar mysnackbar = SnackBar(content: Text('Logging In ...'));
          ScaffoldMessenger.of(context).showSnackBar(mysnackbar);

          await userdata.write('key_username', data["username"]);
          await userdata.write('key_logStatus', true);
          Get.offAll(CustomerDashboard());
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => CustomerDashboard()));
        } else {
          print("No user found");
          SnackBar mysnackbar = SnackBar(content: Text('check credentials'));
          ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
        }
      } else {
        print("failed");
        SnackBar mysnackbar = SnackBar(content: Text('fill all fields'));
        ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  User user = User('', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // new Positioned.fill(
                    //   top: 0.0,
                    //   child: SvgPicture.asset(logo),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "LOG IN",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: user.email,
                            ),
                            onChanged: (value) {
                              user.email = value;
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter something';
                              } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)) {
                                return null;
                              } else {
                                return 'Enter valid email';
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_sharp,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                hintText: "Email"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: user.password,
                            ),
                            onChanged: (value) {
                              user.password = value;
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                hintText: "Password"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        //final isUserValid =
                        verifyUser(user.email, user.password);
                        //print(isUserValid);
                        // if (isUserValid) {
                        //   print("valid");
                        // } else {
                        //   print("invalid");
                        // }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CustomerDashboard()));
                        // if (_formKey.currentState?.validate() == true) {
                        //   print(user.email);
                        //   print(user.password);
                        //   save();
                        // } else {
                        //   final snackBar =
                        //       SnackBar(content: Text('Check Credentials'));
                        //   print("check credentials");
                        // } //
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey,
                                Colors.blueGrey,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(

                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not a member? ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            "Regester Now",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
