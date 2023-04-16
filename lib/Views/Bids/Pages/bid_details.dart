import 'dart:convert';
import 'dart:io';


import 'package:bina_github/Views/Bids/Pages/place_an_offer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Widgets/snackbar.dart';
import '../../../Widgets/solid_button.dart';
import '../../../constants/constants.dart';
import '../Model/bid_details.dart';

class BidDetailsPage extends StatefulWidget {
  final bidId;
  final countBids;

  const BidDetailsPage({Key? key, this.bidId, required this.countBids})
      : super(key: key);

  @override
  State<BidDetailsPage> createState() => _BidDetailsPageState();
}

class _BidDetailsPageState extends State<BidDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
    getBidList(bidId);
  }

  var bidId = '';
  var bidData;
  var countBids = '';

  getSharedPreference() {
    print(
        'before setting bid_id---------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$bidId');
    setState(() {
      bidId = widget.bidId.toString();
      countBids = widget.countBids.toString();
      print(
          'after setting bid_id---------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$bidId');
    });
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

  bool isLoading = true;
  bool isProgressLoading = true;
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF304803),
          title: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text('Bidetail'.tr()),
          ),
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_sharp)),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                    "${ApiConstants.imageUrl}${bidData.image.toString()}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/bina_logo.png',
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                            AssetImage('assets/images/bina_logo.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin:
              //       EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: Image.network(
              //         ApiConstants.imageUrl + bidData.image.toString(),
              //         fit: BoxFit.fill,
              //       )),
              // ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  bidData.title.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20),
                child: Text(
                  bidData.description.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                margin: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        'download'.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var tempDir = await getTemporaryDirectory();
                        String fullPath = tempDir.path +
                            '/' +
                            bidData.file.replaceAll('uploads/user/', '');
                        print(bidData.file);
                        print(fullPath);
                        var pdfUrl =
                            '${ApiConstants.imageUrl}${bidData.file.toString()}';
                        print(pdfUrl);
                        download2(dio, pdfUrl, fullPath);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10, right: 5),
                        child: CircleAvatar(
                          radius: 18,
                          child: Icon(
                            Icons.file_download_sharp,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 10),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, .1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('scheduleDate'.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                )),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(bidData.bidTillDate.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'endingDuration'.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(bidData.bidTill.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'currentBid'.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(countBids.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context, MaterialPageRoute(builder: (_) => PlaceBid()));
              //     },
              //     child: reusableSolidButton('Place Bid')),
              // Row(children: <Widget>[
              //   Expanded(child: Divider(color: Colors.black38
              //     ,indent: 25,endIndent: 10,)),
              //   Text("or"),
              //   Expanded(child: Divider(color: Colors.black38,endIndent: 25,indent: 10,)),
              // ]),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                PlaceAnOfferPage(var1: bidId)));
                  },
                  child: reusableSolidButton('placeAnoffer'.tr()))
            ],
          ),
        ));
  }

  Future getBidList(String bid_id) async {
    var queryParameters = {"bid_id": bid_id};
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.getBidDetailsEndPoint)
        .replace(queryParameters: queryParameters);
    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      var bidsListResponse =
      bidDetailsModel.fromJson(jsonDecode(response.body));
      if (bidsListResponse.bidList != null) {
        bidData = bidsListResponse.bidList!.bidList;
      } else {
        SnackBarService.showSnackBar(context, 'no details ');
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
