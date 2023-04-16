import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import 'Model/applied_candidate_model.dart';

class CandidateDetailsPage extends StatefulWidget {
  final userId;
  final vaccancyId;

  const CandidateDetailsPage({Key? key, this.userId, this.vaccancyId})
      : super(key: key);

  @override
  State<CandidateDetailsPage> createState() => _CandidateDetailsPageState();
}

class _CandidateDetailsPageState extends State<CandidateDetailsPage> {
  bool isLoading = true;
  var appliedList;
  var user_id = '';
  var vaccancy_id = '';
  var candidateDetailsList = [];
  var _openResult = 'Unknown';
  final dio = Dio();
  bool isProgressLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  Future<void> openFile(filePath) async {
    print(
        'inside open file function-------------->>>>>>>>>>>>>>>>>>>>>>>.....');
    // const filePath = '/storage/emulated/0/Download/flutter.png';
    // const filePath =
    //     'https://binaadmin.witvisitor.in/uploads/user/Home_Page_changes_Ui_compressed.pdf';
    final result = await OpenFilex.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  getSharedPreference() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    print(
        "inside shared prefernce------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print("user_id before setting:-$user_id");
    print("vaccancy_id before setting:-$vaccancy_id");
    setState(() {
      user_id = widget.userId;
      vaccancy_id = widget.vaccancyId;
      print("user_id after setting:-$user_id");
      print("vaccancy_id after setting:-$vaccancy_id");
    });
    getAppliedCandidateDetails(user_id, vaccancy_id);
    // getVacanciesPosted(user_id);
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
          title: Text('candidateDetails'.tr()),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xFF304803),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 25, top: 10, left: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, top: 10, bottom: 10),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  ApiConstants.imageUrl +
                                      candidateDetailsList[index]
                                          .userImage
                                          .toString()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 30,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // appliedList.name.toString() != null
                                Text(
                                  candidateDetailsList[index]
                                      .name
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'job'.tr(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0),
                                      child: Text(
                                        candidateDetailsList[index]
                                            .jobsType
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'basicInformation'.tr(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Column(
                        children: [
                          reusableRowWidget(
                              'fullName'.tr(),
                              candidateDetailsList[index]
                                  .name
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'experience'.tr(),
                              candidateDetailsList[index]
                                  .totalExperienceYear
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'email'.tr(),
                              candidateDetailsList[index]
                                  .email
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'contact'.tr(),
                              candidateDetailsList[index]
                                  .mobile
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'dateApplied'.tr(),
                              candidateDetailsList[index]
                                  .createdAt
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'location'.tr(),
                              candidateDetailsList[index]
                                  .city
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'qualification'.tr(),
                              candidateDetailsList[index]
                                  .qualification
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                          reusableRowWidget(
                              'expectedSalary'.tr(),
                              candidateDetailsList[index]
                                  .expectedSalary
                                  .toString()),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      // Expanded(
                      //   child: Container(
                      //     height: 40,
                      //     margin: EdgeInsets.symmetric(horizontal: 10),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(color: Colors.black),
                      //         // borderRadius: BorderRadius.circular(10),
                      //         color: Color(0xFF304803)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           'Call',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 12,
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 8.0),
                      //           child: Icon(
                      //             Icons.call,
                      //             size: 15,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            var tempDir = await getTemporaryDirectory();
                            String fullPath = tempDir.path +
                                '/' +
                                candidateDetailsList[index]
                                    .resume
                                    .replaceAll('uploads/user/', '');
                            print(candidateDetailsList[index]
                                .resume
                                .toString());
                            print(fullPath);
                            var pdfUrl =
                                '${ApiConstants.imageUrl}${candidateDetailsList[index].resume.toString()}';
                            print(
                                "resume url--------------->>>>>>>>>>>>>>>>>>>>>>${candidateDetailsList[index].resume!.toString()}");
                            download2(dio, pdfUrl, fullPath);
                          },
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Color(0xFF304803)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'resume'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.download_for_offline,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: candidateDetailsList.length,
          ),
        ));
  }

  Widget reusableRowWidget(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                content,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getAppliedCandidateDetails(String user_id, String vacancy_id) async {
    var queryparameters = {
      'user_id': user_id,
      'vacancy_id': vacancy_id,
    };
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.candidateDetailsEndPoint)
        .replace(queryParameters: queryparameters);
    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var vaccancytotalResponse =
      appliedCandidateDetailsModel.fromJson(jsonDecode(response.body));
      if (vaccancytotalResponse.status == true) {
        setState(() {
          isLoading = false;
        });
        // appliedList = vaccancytotalResponse.appiledList![0];//commented for now
        print(vaccancytotalResponse.status);
        print('sucesss in candidate details---------------->>>>>>>>>>>>>>>>');
        print(vaccancytotalResponse.appiledList!);
        candidateDetailsList = vaccancytotalResponse.appiledList!;
      } else {
        print(vaccancytotalResponse.status);
        print('failure in candidate details---------------->>>>>>>>>>>>>>>>');
      }
    }
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      // OpenFile.open(savePath);
      openFile(savePath);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void showDownloadProgress(received, total) {
    setState(() {
      isProgressLoading = true;
    });
    if (total != -1) {
      setState(() {
        isProgressLoading = false;
      });

      print((received / total * 100).toStringAsFixed(0) + "%");
      // SnackBarService.showSnackBar(
      //     context, (received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
