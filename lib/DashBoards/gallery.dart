import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class User {
  final String imageKey, imageName;
  User(this.imageKey, this.imageName);
}

class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key}) : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {

  final userdata = GetStorage();

  late List<User> _users = [emplyUser];

  User emplyUser = new User('none found', 'none found');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }
  _asyncMethod() async {
    _users = await getImages();
    setState(() {

    });
  }

  Future<List<User>> getImages() async {
    try {
      var url =
          'https://ticketeasy.tk/api/imagesList/${userdata.read('key_username')}';

      var res = await http.get(Uri.parse(url));
      var data = json.decode(res.body.toString());
      print(res.body);

      List<User> users = [];
      for (var u in data["images"]) {
        User user =
        User(u['imageKey'], u['imageName']);
        users.add(user);
      }
      print(users.length);


      return users as List<User>;
    } catch (e) {
      print(e.toString());
      throw 'failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10.0),
          child:
          Container(

            child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  User user = _users[index];
                  if (_users == null) {
                    return Container(

                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Column(
                        children: [
                          Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(user.imageName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blue)),
                              ),]),),
                        ],
                      ),
                    );
                  }
                }),
          ),


        ),
      ),
    );
  }
}
