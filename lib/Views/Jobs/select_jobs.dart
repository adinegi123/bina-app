import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import 'Model/select_job_type.dart';

class SelectJobTypesPage extends StatefulWidget {
  const SelectJobTypesPage({Key? key, var data}) : super(key: key);

  @override
  State<SelectJobTypesPage> createState() => _SelectJobTypesPageState();
}

class _SelectJobTypesPageState extends State<SelectJobTypesPage> {
  bool isLoading = true;

  // var jobTypes = [];
  var isChecked = 0;
  var cityList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xFF91C121),
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Select Job Type",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async{
                  setState(() {
                    isChecked = index;
                    final data = {
                      "value": cityList[index].jobsType,
                      "jobId": cityList[index].id,
                    };
                    Navigator.of(context).pop(data);
                  });
                },
                child: Card(
                  child: SizedBox(
                    height: 50,
                    child: ListTile(
                      tileColor:
                      isChecked == index ? Colors.green : Colors.white,
                      title: Center(
                          child: Text(cityList[index].jobsType.toString())),
                    ),
                  ),
                ),
              );
            },
            itemCount: cityList.length,
            physics: BouncingScrollPhysics()),
      ),
    );
  }

  Future getJobTypeList() async {
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.JobListTypeEndPoint);
    var response = await http.get(url);

    if (!mounted) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var stateResponse =
      jobTypeListModelClass.fromJson(jsonDecode(response.body));
      if (stateResponse.status == true) {
        // print(stateResponse.result!.length.toString());
        cityList = stateResponse.jobTypeList!;
        print(
            "in select city page------>>>>>>>>>>>>>>${cityList[3].jobsType!}");
      } else {
        print('error occurred while fetching list');
      }
    }
  }
}
