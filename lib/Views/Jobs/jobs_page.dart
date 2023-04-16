import 'dart:convert';


import 'package:bina_github/Views/Jobs/add_a_job.dart';
import 'package:bina_github/Views/Jobs/total_vacancy_created.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../constants/color.dart';
import '../../constants/constants.dart';
import 'Model/count_applied_candidates.dart';
import 'Model/vacancy_number.dart';
import 'vaccancy_page.dart';



class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  bool isLoading = true;
  var vaccancyTotal;
  var appliedCandidatesTotal;
  var user_id = '';
  var user_type = '';
  var jobs_type = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();



    // getvaccancyList();
  }

  getSharedPreference() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    print(
        "inside shared prefernce------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print("user_id before setting:-$user_id");
    print("user_type before setting:-$user_id");
    print("jobs_type before setting:-$jobs_type");
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      user_type = myPref.getString("type") ?? "";
      jobs_type = myPref.getString("jobs_type_apply_id") ?? "";
      print(
          "user_id after setting inside get shared preference:--------------$user_id");
      print("user_type after setting:-$user_type");
      print("job_type after setting:-$jobs_type");
    });
    getvaccancyCount(jobs_type);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_sharp,
            )),
        title: Text('Jobs'.tr()),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AddJobPage()));
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 7, vertical: 9),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.add,
                    ))),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => VaccancyPage()));
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, .1),
                  ),
                ], border: Border.all(color: ColorConst.buttonColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ))),
                    )
                        : Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 30,
                        width: 40,
                        child: Center(
                            child: (vaccancyTotal != null)
                                ? Text(
                              vaccancyTotal.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )
                                : Text(
                              '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, .1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                      child: Center(
                        child: Text(
                          'vaccancy'.tr().toString().toLowerCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          user_type == 'company'
              ? Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TotalVaccancyCreatedPage()));
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ))),
                    )
                        : Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, .1),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                              appliedCandidatesTotal.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 20.0, top: 10),
                      child: Center(
                        child: Text(
                          'candidate'.tr().toString().toLowerCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  Future getvaccancyCount(String job_type) async {
    var queryParameters = {'job_type': job_type};
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.totalVaccancyEndPoint)
        .replace(queryParameters: queryParameters);
    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var vaccancytotalResponse =
      vaccancynumberModelClass.fromJson(jsonDecode(response.body));
      if (vaccancytotalResponse.status == true) {
        print(
            "in jobs page ------------> total vaccancy length${vaccancytotalResponse!.totalVacancy.toString()}");
        vaccancyTotal = vaccancytotalResponse!.totalVacancy;
        print('user id inside get tota vacancy----------------->>>>>>>>>>>>>>>>>$user_id');
        getCountAppliedCandidates(user_id);
        // cityList = stateResponse.result!;
        // print(cityList[3].name!);
      } else {
        print('error occurred while fetching list');
      }
    }
  }

  Future getCountAppliedCandidates(String user_id) async {
    var queryparameters = {'user_id': user_id};
    print('user id sent-------------->$user_id');
    var url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.CountAppliedCandidatesEndPoint).replace(queryParameters: queryparameters);
    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var vaccancytotalResponse =
      appliedcandidatesCountModelClass.fromJson(jsonDecode(response.body));
      if (vaccancytotalResponse.status == true) {
        print(
            "in jobs page ------------> total applied candidates length${vaccancytotalResponse!.countAppiliedCadidates.toString()}");
        appliedCandidatesTotal = vaccancytotalResponse!.countAppiliedCadidates.toString();
        // cityList = stateResponse.result!;
        // print(cityList[3].name!);
      } else {
        SnackBarService.showSnackBar(context, "no candidates applied");
        print('error in count applied candidates');
      }
    }
  }
}
