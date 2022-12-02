import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class User {
  final String organization, category, query, status;
  User(this.organization, this.category, this.query, this.status);
}

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {

  final userdata = GetStorage();

  late List<User> _users = [emplyUser];

  User emplyUser = new User('none found', '', '', '');

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_){
    _asyncMethod();
  });

  }
  _asyncMethod() async {
      _users = await getTickets();
      setState(() {

    });
  }

  Future<List<User>> getTickets() async {
    try {
      var url =
          'https://ticketeasy.tk/api/v1/getUserTickets?username=${userdata.read('key_username')}';

      var res = await http.get(Uri.parse(url));
      var data = json.decode(res.body);
      print(res.body);

      List<User> users = [];
      for (var u in data["tickets"]) {
        User user =
            User(u['organizationName'], u['category'], u['query'], u['status']);
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
    // TODO: implement build
    return Scaffold(
      body: Padding(
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
                                  child: Text(user.organization,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blue)),
                                ),Text(user.category),Text(user.query),Text(user.status,)]),),
                          ],
                        ),
                      );
                    }
                  }),
            ),
          
        
      ),
    );
  }
}
