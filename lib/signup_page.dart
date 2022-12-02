import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trail/DashBoards/CustomerDashboard.dart';
import 'package:trail/login_page.dart';

import 'package:http/http.dart' as http;
const logo = 'assets/logo.svg';


class User {
  String userName;
  String email;
  String phone;
  String password;
  User(this.userName, this.email, this.phone, this.password);
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // signup(cust) Post Req---> http://localhost:1337/api/v1/registerCustomer

  final _formKey = GlobalKey<FormState>();

  Future<void> save(
      String UserName, String email, String phone, String password) async {
    try {
      Map<String, String> customHeaders = {"content-type": "application/json"};
      final res = await http.post(
          Uri.parse("https://ticketeasy.tk/api/v1/registerCustomer"),
          headers: customHeaders,
          body: json.encode({
            'username': user.userName,
            'email': user.email,
            'phone': user.phone,
            'password': user.password
          }));

      if (res.statusCode == 200) {
        final data = await json.decode(res.body) as Map;
        print(data);
        if (data["status"]=="ok") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        }else{
          print("isuue with cred");
        }
        
      }
    } catch (e) {
      print(e.toString());
    }
  }

  User user = User('', '', '', '');

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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: user.userName,
                            ),
                            onChanged: (value) {
                              user.userName = value;
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter username';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "UserName",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ),
                            ),
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              border: InputBorder.none,
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.deepPurple,
                              ),
                            ),
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: user.phone,
                            ),
                            onChanged: (value) {
                              user.phone = value;
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter Mobile Number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mobile Number",
                              prefixIcon: Icon(
                                Icons.call,
                                color: Colors.deepPurple,
                              ),
                            ),
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              border: InputBorder.none,
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.password,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 25,),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border.all(color: Colors.white),
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 15),
                    //       child: TextFormField(
                    //         controller: TextEditingController(
                    //           text: user.password,
                    //         ),
                    //         onChanged: (value){
                    //           user.password=value;
                    //         },
                    //         validator: (value){
                    //           if(value == user.password){
                    //             return null;
                    //           } else{
                    //             return 'match the above password';
                    //           }
                    //         },
                    //         obscureText: true,
                    //         decoration: InputDecoration(
                    //             border: InputBorder.none,
                    //             hintText: "Confirm password",
                    //           prefixIcon: Icon(Icons.password_outlined, color: Colors.deepPurple,),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        save(user.userName, user.email, user.phone,
                            user.password);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.deepPurple,
                                Colors.blue,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
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
                        Text("Already a member? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Get back Now",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
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
