import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trail/login_page.dart';

import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              SizedBox(height: 20,),
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      
                      boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Color.fromARGB(255, 173, 176, 180).withOpacity(0.1)
                      ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://cdn-icons-png.flaticon.com/512/1077/1077012.png")
                      )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditProfile()));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Color.fromARGB(149, 90, 182, 252)
                        ),
                        child: Icon(Icons.edit, color: Colors.white),

                      ),
                    ))
                ],
              ),
              SizedBox(height: 20,),
              Center(
                  child: Text(
                '${userdata.read('key_username')}',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 39, 39, 39)),
              )),
              SizedBox(height: 350,),




              TextButton(onPressed: (){
                SnackBar mysnackbar = SnackBar(content: Text('Logged out'));
                ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
                userdata.write('key_logStatus', false);
                userdata.remove('key_username');
                Get.offAll(LoginPage());

              }, child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueGrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Log out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),),
                ),
              )),


              
              

            ],
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }
}
