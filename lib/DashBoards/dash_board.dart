import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trail/DashBoards/CustomerDashboard.dart';
import 'package:trail/DashBoards/image_upload.dart';

import 'gallery.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'Dashboard',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
            )),
            SizedBox(
              height: 20,
            ),
            TicketForm(),
            SizedBox(
              height: 40,
            ),
            UploadImage(),

            //ImageGallery(),
          ],
        ),
      ),
    );
  }

  
}



