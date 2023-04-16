import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../constants/constants.dart';
import 'Model/vacancy_posted.dart';
import 'candidates_page.dart';


class TotalVaccancyCreatedPage extends StatefulWidget {
  const TotalVaccancyCreatedPage({Key? key}) : super(key: key);

  @override
  State<TotalVaccancyCreatedPage> createState() =>
      _TotalVaccancyCreatedPageState();
}

class _TotalVaccancyCreatedPageState extends State<TotalVaccancyCreatedPage> {
  var jobtype = 'Mechanical';
  bool isLoading = true;
  var user_id = '';
  var dataList = [];

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
    print("user_id before setting:-$user_id");
    print("user_type before setting:-$user_id");
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      print("user_id after setting:-$user_id");
    });
    getVacanciesPosted(user_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
        title: Text('vacancyPosted'.tr()),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'vacancyPostedbyu'.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                )),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Card(
                    surfaceTintColor: Colors.green.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15, top: 20, left: 15, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "jobTitle".tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              dataList[index].jobTitle,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "location".tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              dataList[index].location.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "salaryRange".tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              dataList[index].salaryRange.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "jobDescription".tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    dataList[index]
                                        .jobDescription
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CandidatesPage(
                                                    vaccancyId: dataList[
                                                    index]
                                                        .id
                                                        .toString())));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(6.0),
                                      color:
                                      Colors.green.withOpacity(0.1),
                                      child: Text(
                                        'seeMore'.tr(),
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future getVacanciesPosted(String userId) async {
    var queryparameters = {'userId': userId};
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.vacanciesPosted)
        .replace(queryParameters: queryparameters);
    var response = await http.post(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var vaccancypostedResponse =
      vaccancyPostedModel.fromJson(jsonDecode(response.body));
      if (vaccancypostedResponse.status == true) {
        print('---------->>>>>>>>>>>>>>>200');
        dataList = vaccancypostedResponse.data!;
      } else {
        print('error ->>>>>>>>>>>>>>>>>>>>>>>>>>');
        SnackBarService.showSnackBar(
            context, vaccancypostedResponse.message.toString());
      }
    }
  }
}
