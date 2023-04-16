
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color.dart';
import 'add_vacancy.dart';
import 'looking_for_a_job.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  getSharedPreference() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    print(
        "inside shared prefernce------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print("user_id before setting:-$user_type");
    setState(() {
      user_type = myPref.getString("type") ?? "";
      print("user_type after setting:-$user_type");
    });
  }

  var user_type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddaVaccancyPage()));
            },
            child: user_type == 'company'
                ? Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, .1),
                ),
              ], border: Border.all(color: ColorConst.buttonColor)),
              child: Center(
                child: Text(
                  'Add Vaccancy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
                : Container(),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LookingForAJobPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, .1),
                ),
              ], border: Border.all(color: ColorConst.buttonColor)),
              child: Center(
                child: Text(
                  'Looking for a Job',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
