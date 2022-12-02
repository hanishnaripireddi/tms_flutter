import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trail/DashBoards/dash_board.dart';
import 'package:trail/DashBoards/profile_Page.dart';
import 'package:trail/DashBoards/tickets_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({Key? key}) : super(key: key);

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int index = 0;

  final userdata = GetStorage();

  final screens = [
    DashBoard(),
    TicketsPage(),
    ProfilePage(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[index]),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.grey[100],
          backgroundColor: Colors.white54,
          labelTextStyle: MaterialStateProperty.all(TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 100, 126, 166))),
        ),
        child: NavigationBar(
            height: 70,
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined,
                  color: Colors.grey[400],),
                  selectedIcon: Icon(Icons.dashboard,
                  color: Colors.blueGrey,
                  size: 30,),
                  label: 'Dashboard'),
              NavigationDestination(
                  icon: Icon(Icons.receipt_outlined,
                    color: Colors.grey[400],),
                  selectedIcon: Icon(Icons.receipt,
                    color: Colors.blueGrey,
                    size: 30,),
                  label: 'Tickets'),
              NavigationDestination(
                  icon: Icon(Icons.person_outlined,
                    color: Colors.grey[400],),
                  selectedIcon: Icon(Icons.person,
                    color: Colors.blueGrey,
                    size: 30,),
                  label: 'Profile'),
            ]),
      ),
    );
  }
}

class User {
  String organization;
  String category;
  String username;
  String query;
  User(this.organization, this.category, this.username, this.query);

}

class TicketForm extends StatefulWidget {
  const TicketForm({Key? key}) : super(key: key);

  @override
  State<TicketForm> createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  final _formKey = GlobalKey<FormState>();
  final userdata = GetStorage();

  String dropdownvalue = 'Technical';

  // List of items in our dropdown menu
  var items = [
    'Technical',
    'How to',
    'Feature Request',
  ];

  final String organization = 'Google';


  Future<void> raiseTicket(
      String category, String query) async {
    try {
      Map<String, String> customHeaders = {"content-type": "application/json"};

      var username = userdata.read('key_username');
      if(user.category==''){
        user.category='Technical';
      }


      final res = await http.post(
          Uri.parse("https://ticketeasy.tk/api/v1/addNewTicket"),
          headers: customHeaders,

          body: json.encode({
          'organizationName': organization,
          'category': user.category,
          'username': userdata.read('key_username'),
          'query':user.query,
          }));

      if (res.statusCode == 200) {
        final data = await json.decode(res.body) as Map;
        print(data);
        if (data["status"]=="ok") {
          print("ticket submitted");
          SnackBar mysnackbar = SnackBar(content: Text('Ticket Submitted'));
          ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomerDashboard()));
        }else{
          print("isuue with cred");
          SnackBar mysnackbar = SnackBar(content: Text('submit all fields'));
          ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
        }

      }
    } catch (e) {
      print(e.toString());
    }
  }

  User user = User('', '', '', '');






  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Create a new ticket",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: DropdownButtonFormField(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {

                    setState(() {
                      dropdownvalue = newValue!;

                    });
                    user.category=newValue!;

                  },
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
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: TextEditingController(
                        text: user.query,
                      ),
                      onChanged: (value){
                        user.query = value;
                      },
                      validator: (value){
                        if (value?.isEmpty ?? true) {
                          return 'empty';

                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Enter Remarks"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                raiseTicket(user.category,user.query);

              }, child: Container(

                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Submit ticket',
                  style: TextStyle(
                    fontSize: 20,
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
  }
}
