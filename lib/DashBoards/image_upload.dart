import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'CustomerDashboard.dart';
import 'gallery.dart';


class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  late String imagepath;
  final _picker = ImagePicker();
  bool showSpinner = false;
  final userdata = GetStorage();

  Future getImage() async {

    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);


    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {
         imagepath = pickedFile.path;
      });
    } else {
      print("no image");
    }
  }

  Future cameraImage() async{
    final pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 30);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {
        imagepath = pickedFile.path;
      });
    } else {
      print("no image");
    }
  }

  Future<void> uploadImage() async {

     // var stream = http.ByteStream(image!.openRead());
     // stream.cast();


    // var length = await image!.length();
    var uri = Uri.parse("https://ticketeasy.tk/api/uploadImage");
    var req = new http.MultipartRequest('POST', uri);
    req.fields['username'] = "${userdata.read('key_username')}";
    var multipart = await http.MultipartFile.fromPath('image', imagepath, contentType: new MediaType('image','jpeg'));
    req.files.add(multipart);

    var res = await req.send();


     print(res);


    if (res.statusCode == 200) {
      print(res);

      print('image uploaded');
      SnackBar mysnackbar = SnackBar(content: Text('Image submitted'));
      ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomerDashboard()));
    } else {

      print("not uploaded");
      SnackBar mysnackbar = SnackBar(content: Text('Server issue,please try again'));
      ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],

        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 120,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  border: Border.all(color: Color.fromRGBO(57, 157, 248, 0.8)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: image == null
                    ? Center(
                        child: Text("Pick from gallery",
                        style: TextStyle(
                            color:Color.fromRGBO(57, 157, 248, 0.8),
                        ),),
                      )
                    : Container(
                        child: Center(
                            child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ))),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      cameraImage();
                    },
                    child: Center(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(86, 86, 86, 1.0),
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: Text("Camera",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(255, 255, 255, 1),

                              ),)))),
                SizedBox(width: 20,),

                GestureDetector(
                    onTap: (){
                      uploadImage();
                      image==null;
                    },
                    child: Center(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(68, 127, 217, 1.0),
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: Text("Upload",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),)))),

              ],
            ),

            TextButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageGallery()));
            }, child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Image Gallery',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey,
                ),),
              ),
            )),





          ],

      ),
    );
  }
}
