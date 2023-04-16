import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../Widgets/snackbar.dart';
import '../../constants/constants.dart';
import 'Model/applied_candidates_list.dart';
import 'candidate_details.dart';

class CandidatesPage extends StatefulWidget {
  final vaccancyId;

  const CandidatesPage({Key? key, this.vaccancyId}) : super(key: key);

  @override
  State<CandidatesPage> createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  bool isLoading = true;
  var appliedCandidateList = [];
  final dio = Dio();
  bool isProgressLoading = true;
  var vaccancy_id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  getSharedPreference() async {
    print("user_id before setting:-$vaccancy_id");
    setState(() {
      vaccancy_id = widget.vaccancyId.toString();
      print("user_id after setting:-$vaccancy_id");
    });
    getappliedCandidateList(vaccancy_id);
  }

  var _openResult = 'Unknown';

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
        title: Text('candidates'.tr()),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10),
                child: Text(
                  'appliedCandidates'.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                )),
            ListView.builder(
              itemBuilder: (context, index) =>
                  InkWell(
                      onTap: () {
                        print(
                            'user id sent to the next page-->${appliedCandidateList[index]
                                .userId!.toString()}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    CandidateDetailsPage(
                                        userId: appliedCandidateList[index]
                                            .userId
                                            .toString(),
                                        vaccancyId: vaccancy_id)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, top: 10, bottom: 10),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            ApiConstants.imageUrl +
                                                appliedCandidateList[index]
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            appliedCandidateList[index]
                                                .name!
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'experience'.tr(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            appliedCandidateList[index]
                                                .totalExperienceYear!
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 9,
                                            ),
                                          ),
                                          Text(
                                            'location'.tr(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                              appliedCandidateList[index]
                                                  .city!
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 9,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    var tempDir =
                                    await getTemporaryDirectory();
                                    String fullPath = tempDir.path +
                                        '/' +
                                        appliedCandidateList[index]
                                            .resume
                                            .replaceAll('uploads/user/', '');
                                    print(appliedCandidateList[index]
                                        .resume
                                        .toString());
                                    print(fullPath);
                                    var pdfUrl =
                                        '${ApiConstants
                                        .imageUrl}${appliedCandidateList[index]
                                        .resume.toString()}';
                                    print(
                                        "resume url--------------->>>>>>>>>>>>>>>>>>>>>>${appliedCandidateList[index]
                                            .resume!.toString()}");
                                    download2(dio, pdfUrl, fullPath);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF304803)),
                                    child: Row(
                                      children: [
                                        Text(
                                          'downloadCv'.tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0),
                                          child: Icon(
                                            Icons.download,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
              itemCount: appliedCandidateList.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }

  Future getappliedCandidateList(String vacancyId) async {
    var queryparameters = {'vacancyId': vacancyId};

    print(
        'vacancyId sent inside get applied candidate list api----------->>>>>>>$vacancyId');
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.vaccancycandidateList)
        .replace(queryParameters: queryparameters);
    var response = await http.post(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(response.body);

      var appliedCandidateResponse =
      candidateListModel.fromJson(jsonDecode(response.body));
      print(appliedCandidateResponse.status);
      if (appliedCandidateResponse.status == true) {
        print('sucess-------------->>>>>>>>>>>>.');
        appliedCandidateList = appliedCandidateResponse.data!;
        print(appliedCandidateResponse.data!);
        // SnackBarService.showSnackBar(
        //     context, appliedCandidateResponse.message.toString());
      } else {
        SnackBarService.showSnackBar(
            context, appliedCandidateResponse.message.toString());
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
