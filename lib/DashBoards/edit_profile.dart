import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:trail/DashBoards/profile_Page.dart';


class User {
  String username;
  String email;
  String phone;

  User(this.username,this.email, this.phone);
}


class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userdata = GetStorage();



  final _formKey = GlobalKey<FormState>();

  Future<void> changeDetails(
      String email, String phone) async {
    try {
      Map<String, String> customHeaders = {"content-type": "application/json"};
      final res = await http.put(
          Uri.parse("https://ticketeasy.tk/api/v1/editCustomer"),
          headers: customHeaders,
          body: json.encode({
            'username':userdata.read('key_username'),
            'email': user.email,
            'phone': user.phone,
          }));

      if (res.statusCode == 200) {
        final data = await json.decode(res.body) as Map;
        print(data);
        if (data["status"]=="ok") {
          SnackBar mysnackbar = SnackBar(content: Text('Changes saved'));
          ScaffoldMessenger.of(context).showSnackBar(mysnackbar);

        }else{
          print("isuue with cred");
          SnackBar mysnackbar = SnackBar(content: Text('try again later'));
          ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
        }

      }
    } catch (e) {
      print(e.toString());
    }
  }

  User user = User('', '', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'Edit Profile ',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
              )),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Usermane: "),
                  Text("${userdata.read('key_username')}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey,
                  ),)
                ],
              ),
              SizedBox(height: 30,),


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
                      // controller: TextEditingController(
                      //   text: user.email,
                      // ),
                      // onChanged: (value) {
                      //   user.email = value;
                      // },
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
                        hintText: " New Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

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
                      // controller: TextEditingController(
                      //   text: user.email,
                      // ),
                      // onChanged: (value) {
                      //   user.email = value;
                      // },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter mobile number';
                        } else if (RegExp(
                            r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/')
                            .hasMatch(value!)) {
                          return null;
                        } else {
                          return 'Enter valid email';
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "New mobile number",
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),


              TextButton(onPressed: (){
                changeDetails(user.email, user.phone);
              }, child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),),
                ),
              ))




            ],
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }
}
