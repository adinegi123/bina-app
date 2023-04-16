import 'dart:convert';

import 'package:bina_github/Views/Jobs/vaccancy_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../constants/constants.dart';
import 'Model/vacancy_list_model.dart';

class VaccancyPage extends StatefulWidget {
  const VaccancyPage({Key? key}) : super(key: key);

  @override
  State<VaccancyPage> createState() => _VaccancyPageState();
}

class _VaccancyPageState extends State<VaccancyPage> {
  bool isLoading = true;
  var vaccancyListData = [];
  var jobs_type = '';

  var vaccancy_id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getvaccancyList();
    getSharedPreference();
  }

  getSharedPreference() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    print("jobs_type before setting:-$jobs_type");
    setState(() {
      jobs_type = myPref.getString("jobs_type_apply_id") ?? "";
      print("jobs_type after setting:-$jobs_type");
    });
    getvaccancyList(jobs_type);
  }

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
        title: Text('Vacancy'.tr()),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10),
                child: Text(
                  'recentlyPosted'.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                )),
            ListView.builder(
                itemCount: vaccancyListData.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VaccancyDetailsPage(
                                  vaccancy_id:
                                  vaccancyListData[index].id)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Card(
                        color: Colors.grey.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 28.0,
                                          top: 10,
                                          bottom: 10),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            ApiConstants.imageUrl+ vaccancyListData[index]
                                                .userImage!.toString()),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 30,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        vaccancyListData[index]
                                            .jobTitle !=
                                            null
                                            ? Text(
                                          vaccancyListData[index]
                                              .jobTitle!
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight
                                                  .bold),
                                        )
                                            : Text(''),
                                        // SizedBox(height: 2,),

                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'minimumExperience'.tr(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 10,
                                          ),
                                        ),
                                        (vaccancyListData[index]
                                            .minimumExperienceYear !=
                                            null)
                                            ? Text(
                                          vaccancyListData[index]
                                              .minimumExperienceYear!
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 9,
                                          ),
                                        )
                                            : Text(''),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          vaccancyListData[index]
                                              .location!
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 9,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Text('\$210 ',
                              //     style: TextStyle(
                              //       color: ColorConst.buttonColor,
                              //     ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Future getvaccancyList(String job_type) async {
    var queryParameters = {'job_type': job_type};

    print("job type inside get vaccancy api----------->$job_type");
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.VaccancyListEndPoint)
        .replace(queryParameters: queryParameters);
    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      print(response);
      print(response.body);
      var vaccancyListModelClassResponse =
      vaccancyListModelClass.fromJson(jsonDecode(response.body));
      print(response.body);
      print(vaccancyListModelClassResponse);
      print(vaccancyListModelClassResponse.status);
      if (vaccancyListModelClassResponse.status == true) {
        print(vaccancyListModelClassResponse);

        vaccancyListData = vaccancyListModelClassResponse.totalVacancy!;
        print(
            'true response-------------------------------------->>>>>>>>>>>>>>');
        // cityList = stateResponse.result!;
        // print(cityList[3].name!);
      } else {
        print(
            "false response------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");
        SnackBarService.showSnackBar(context, 'no vaccancy right now!');
        SnackBarService.showSnackBar(
            context, 'Please update your job profile!');
      }
    }
  }
}
