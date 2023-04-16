import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../Model/get_bid_list.dart';
import 'bid_details.dart';
import 'create_a_bid.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({Key? key}) : super(key: key);

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBidList();
  }

  bool isLoading = true;
  bool isStatusTrue = false;
  var bidsDataList = [];
  var bidId = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text('Bids'.tr()),
          ),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(0xFF304803),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_sharp)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CreateABidPage()));
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
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            unselectedLabelColor: Colors.black,
            tabs: [
              const Tab(
                child: Text(
                  'Live',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//
                isStatusTrue
                    ? Padding(
                  padding: const EdgeInsets.only(
                      left: 22.0, top: 10, bottom: 7, right: 20),
                  child: Text(
                    'liveBids'.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(
                      left: 22.0, top: 10, bottom: 7, right: 20),
                  child: Text(
                    'No Live Bids yet!',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: bidsDataList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BidDetailsPage(
                                    bidId:
                                    bidsDataList[index].id.toString(),
                                    countBids: bidsDataList[index]
                                        .countList
                                        .toString())));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: const Offset(0, .1),
                          ),
                        ], borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            //
                            SizedBox(
                              height: 95,
                              width: 140,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "${ApiConstants.imageUrl}${bidsDataList[index].image.toString()}",
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 150,
                                  placeholder: (context, url) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/bina_logo.png',
                                              ),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/bina_logo.png'),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      bidsDataList[index]
                                          .title
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0, top: 5),
                                        child: Text(
                                          "endingDuration".tr(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 5),
                                        child: Text(
                                          bidsDataList[index]
                                              .endingIn
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xFF304803),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0, top: 5),
                                        child: Text(
                                          "totalBids".tr(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 5),
                                        child: Text(
                                          bidsDataList[index]
                                              .countList
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xFF304803),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         const Text(
                                  //           "Auction by: ",
                                  //           style: TextStyle(
                                  //               color: Colors.green, fontSize: 12),
                                  //         ),
                                  //         Text(
                                  //           " Alfonso Mango",
                                  //           style: TextStyle(
                                  //               color: Colors.grey, fontSize: 12),
                                  //         )
                                  //       ],
                                  //     ),
                                  //
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (_) => PlaceBid()));
                                  //   },
                                  //   child: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 5, vertical: 7),
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.green.withOpacity(0.4),
                                  //         borderRadius:
                                  //             BorderRadius.circular(3)),
                                  //     child: const Center(
                                  //       child: Text(
                                  //         "View Details",
                                  //         style: TextStyle(
                                  //             fontSize: 11,
                                  //             color: Color(0xFF304803),
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future getBidList() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getBidListEndPoint);
    var response = await http.get(url);
    setState(() {
      isLoading = true;
      isStatusTrue = false;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      var bidsListResponse =
      getBidListModelClass.fromJson(jsonDecode(response.body));
      if (bidsListResponse.status == true) {
        isStatusTrue = true;
        print(
            "in Bids page ---------------------------------------->${bidsListResponse.bidList![0].id.toString()}");
        bidsDataList = bidsListResponse.bidList!;
        // print(
        //     "in candidates page ------------>${appliedCandidatesListResponse.appiledList![0].resume.toString()}");    print(
        //     "in candidates page ------------>${appliedCandidatesListResponse.appiledList![0].totalExperienceYear.toString()}");
        // vaccancyTotal = vaccancytotalResponse!.totalVacancy.toString();
        // cityList = stateResponse.result!;
        // print(cityList[3].name!);
        // appliedCandidateList = bidsListResponse.appiledList!;
        // print(appliedCandidateList);
      } else {
        setState(() {
          isStatusTrue = false;
        });
        print('error occurred while fetching list');
      }
    }
  }
}
