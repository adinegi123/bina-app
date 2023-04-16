import 'dart:convert';


import 'package:bina_github/Views/Jobs/Model/vacancy_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:http/http.dart' as http;

import '../../Widgets/snackbar.dart';
import '../../Widgets/solid_button.dart';
import '../../constants/constants.dart';
import '../../constants/images.dart';
import 'Model/job_apply_model.dart';

class VaccancyDetailsPage extends StatefulWidget {
  final vaccancy_id;

  const VaccancyDetailsPage({Key? key, this.vaccancy_id}) : super(key: key);

  @override
  State<VaccancyDetailsPage> createState() => _VaccancyDetailsPageState();
}

class _VaccancyDetailsPageState extends State<VaccancyDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  bool isLoading = true;
  bool isLoadingOnPressed = true;
  bool isLoadingButton = false;
  bool isLoadingtwo = true;
  bool isLoadingnull = true;
  var user_id = '';
  var vaccancy_id = '';
  var vaccancydataList;
  var average_rating;

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    print('user_id before setting-------->$user_id');
    print('vaccancy_id before setting-------->$vaccancy_id');
    print('vaccancy_id coming from widget--------->${widget.vaccancy_id}');
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      vaccancy_id = widget.vaccancy_id;
      print('user_id after setting--------->$user_id');
      print('vaccancy_id after setting----------->$vaccancy_id');
      print('vaccancy_id coming from widget--------->${widget.vaccancy_id}');
    });
    postVaccancyDetails(vaccancy_id);
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
        title: Text(
          'VacancyDetails'.tr(),
        ),
      ),
      body: isLoadingnull
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: ListView.builder(
            itemCount: vaccancydataList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: ClipOval(
                          child: (vaccancydataList[index]
                              .details
                              .userImage !=
                              null)
                              ? CachedNetworkImage(
                            imageUrl: ApiConstants.imageUrl +
                                vaccancydataList[index]
                                    .details
                                    .userImage
                                    .toString(),
                            width: 80.0,
                            height: 80.0,
                            errorWidget: (context, url, error) =>
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                        'assets/images/bina_logo.png')),
                          )
                              : Container(),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            (vaccancydataList[index].details.name != '')
                                ? Text(
                                vaccancydataList[index]
                                    .details
                                    .name
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                                : Text(" ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Divider(
                              thickness: 1,
                              color: Colors.black12,
                              endIndent: 12,
                              indent: 30,
                            ),
                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 2.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.orange,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                      vaccancydataList[index]
                                          .details
                                          .address
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 6.0),
                                    child: VerticalDivider(
                                      thickness: 1,
                                      color: Colors.black12,
                                      endIndent: 2,
                                    ),
                                  ),
                                  vaccancydataList[index]
                                      .details
                                      .sinceYear !=
                                      null
                                      ? Text(
                                      vaccancydataList[index]
                                          .details
                                          .sinceYear
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))
                                      : Text("no data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.grey.shade800,
                        Colors.white,
                      ], radius: 0.85, focal: Alignment.center),
                    ),
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: (1 / .2),
                      ),
                      children: <Widget>[
                        Container(
                          color: Colors.black,
                          child: Center(
                              child: Text(
                                'averageRating'.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              )),
                        ),
                        Container(
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating: average_rating != null
                                    ? double.parse(average_rating!)
                                    : 0.0,
                                minRating: 5,
                                direction: Axis.horizontal,
                                itemSize: 12,
                                ignoreGestures: true,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              // average_rating != null
                              //     ? Text(
                              //         average_rating.toString(),
                              //         // overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(
                              //           color: Colors.grey,
                              //           fontSize: 11,
                              //         ),
                              //       )
                              //     : Text(
                              //         "0",
                              //         // overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(
                              //           color: Colors.grey,
                              //           fontSize: 11,
                              //         ),
                              //       )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          child: Center(
                              child: Text(
                                'membershipId'.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              )),
                        ),
                        Container(
                          color: Colors.black,
                          child: Center(
                              child: Text(
                                vaccancydataList![index]
                                    .details
                                    .membershipId!
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 36,
                    child: SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  child: Image.asset(
                                    Images.pngWatsapp,
                                    height: 30,
                                    width: 30,
                                  ))),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 6.0),
                          //   child: VerticalDivider(
                          //     thickness: 1,
                          //     color: Colors.black12,
                          //   ),
                          // ),
                          // Expanded(
                          //     child: Container(
                          //         child: Icon(
                          //   Icons.call,
                          //   color: Colors.black,
                          // ))),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: VerticalDivider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  child: Icon(Icons.location_on,
                                      color: Colors.orange)))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Introduction'.tr(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 12),
                          child:
                          vaccancydataList![index].details.shortBio ==
                              ""
                              ? Text(
                            "not provided",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black45),
                          )
                              : Text(
                            vaccancydataList![index]
                                .details
                                .shortBio!
                                .toString(),
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black45),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Website'.tr(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child:
                          vaccancydataList![index].details.website !=
                              null
                              ? Text(
                            vaccancydataList![index]
                                .details
                                .website!
                                .toString(),
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.blueAccent),
                          )
                              : Text(
                            "not provided",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'jobDescription'.tr(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                          child: vaccancydataList![index]
                              .details
                              .jobDescription !=
                              null
                              ? Text(
                            vaccancydataList![index]
                                .details
                                .jobDescription!
                                .toString(),
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey),
                          )
                              : Text(
                            "not provided",
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'minimumExperience'.tr(),
                          style: TextStyle(fontSize: 12),
                        ),
                        vaccancydataList![index]
                            .details
                            .minimumExperienceYear !=
                            null
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8),
                          child: Text(
                            vaccancydataList![index]
                                .details
                                .minimumExperienceYear!
                                .toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8),
                          child: Text(
                            "not provided",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'rolesAndResponsibilties'.tr(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                          child: vaccancydataList![index]
                              .details
                              .rolesResponsibility !=
                              null
                              ? Text(
                            vaccancydataList![index]
                                .details
                                .rolesResponsibility!
                                .toString(),
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey),
                          )
                              : Text(
                            "not provided",
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(children: [
                    InkWell(
                        onTap: () async {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => ApplyVaccancyPage()));
                          setState(() {
                            isLoadingButton = true;
                          });
                          await postJobApplyFromCompanyDescription(
                              user_id, widget.vaccancy_id);
                          setState(() {
                            isLoadingButton = false;
                          });
                        },
                        child: reusableSolidButton('applyJob'.tr())),
                    Positioned(
                      top: 6,
                      left: 0,
                      right: 0,
                      child: Visibility(
                        visible: isLoadingButton,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 5,
                                  ))),
                        ),
                      ),
                    ),
                  ]),
                ],
              );
            }),
      ),
    );
  }

  postJobApplyFromCompanyDescription(
      String user_id,
      String vacancy_id,
      ) async {
    var queryParameters = {
      'user_id': user_id,
      'vacancy_id': vaccancy_id,
    };
    print(
        'inside job apply post api post details page------------------------->>>>>>>>>');
    print("value of user_id-------.>$user_id");
    print("value of vaccancy_id-------.>$vaccancy_id");

    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.appliedJobSaveEndPoint)
        .replace(queryParameters: queryParameters);

    var response = await http.post(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
        isLoadingButton = false;
      });
      // success
      print(response);

      var updateProfileResponse = jobapplyfromcompanyDescriptionModelClass
          .fromJson(json.decode(response.body));
      if (updateProfileResponse.status == true) {
        print(updateProfileResponse.message);
        SnackBarService.showSnackBar(
            context, updateProfileResponse.message.toString());
        Navigator.pop(context);
      } else {
        SnackBarService.showSnackBar(
            context, updateProfileResponse.message.toString());
      }
    }
    // print("responseData--->${response.body}");
    // print("finalUrl--->$url");
  }

  postVaccancyDetails(
      String vacancyId,
      ) async {
    var queryParameters = {
      'vacancyId': vacancyId,
    };
    print('this is vacancy id--------->$vacancyId');

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.vaccancyDetails)
        .replace(queryParameters: queryParameters);

    var response = await http.post(url);
    setState(() {
      isLoadingtwo = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoadingtwo = false;
      });
      // success
      print(
          "inside vacancy details page and vaccancy details api======================>>>>>>>>>>>>>>>>>>>");
      print(response);
      print("this is reponse body--------->${response.body}");

      var vaccancyDetailsResponse =
      vaccancyDetailsModelData.fromJson(json.decode(response.body));
      if (vaccancyDetailsResponse.status == true) {
        print('sucesss------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>');
        print('data is not nulll=============================>');
        if (vaccancyDetailsResponse.data != null) {
          setState(() {
            isLoadingnull = false;
          });
          vaccancydataList = vaccancyDetailsResponse.data!;
          average_rating = vaccancyDetailsResponse.data![0].averageRating;
        } else {
          setState(() {
            isLoadingnull = true;
            SnackBarService.showSnackBar(context, "no data");
            print(
                'nulllllllllllllllllll data found--------------------------->>>>>>>>>>>>>');
          });
        }
        // print(vaccancyDetailsResponse.data![0].details!.sinceYear.toString());
      } else {
        SnackBarService.showSnackBar(context, 'some error occurred');
      }
    }
    // print("responseData--->${response.body}");
    // print("finalUrl--->$url");
  }
}
