import 'dart:convert';


import 'package:bina_github/Views/Categories/Model/filter_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;


import '../../Widgets/snackbar.dart';
import '../../constants/constants.dart';
import '../Dashboard/dashboard.dart';
import '../DetailsPage/details_page.dart';
import '../StatePageCategory/state_page_category.dart';


class CategoryDetailsPage extends StatefulWidget {
  final var1;
  final var2;

  const CategoryDetailsPage({Key? key, this.var1, this.var2}) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  var itemSecond = ['sortBy'.tr(), 'higherToLower'.tr(), 'lowerToHigher'.tr()];
  String dropdownvaluesecond = 'sortBy'.tr();
  var locationValue = 'selectCity'.tr();
  var cityName;
  var modelstatusrespnse = '';
  var listData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    postFilterListApi(widget.var1.toString(), widget.var2.toString(),
        locationValue.toString(), dropdownvaluesecond.toString());
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('search'.tr()),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Icon(
                  Icons.search,
                  size: 20,
                ),
              )
            ],
          ),
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Dashboard(userData: '')),
                        (route) => false);
              },
              child: Icon(Icons.arrow_back_ios_sharp)),
          elevation: 0.0,
          backgroundColor: Color(0xFF304803),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 5.0, right: 15),
                      child: Text(
                        'filter'.tr(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 10),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvaluesecond,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: itemSecond.map((String item) {
                            // print(user_type);
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvaluesecond = newValue!;
                              postFilterListApi(
                                  widget.var1.toString(),
                                  widget.var2.toString(),
                                  locationValue.toString(),
                                  dropdownvaluesecond.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final newValue = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StatePageCategory(data: cityName),
                            ));

                        setState(() {
                          locationValue = newValue["name"];
                          postFilterListApi(
                              widget.var1.toString(),
                              widget.var2.toString(),
                              locationValue.toString(),
                              dropdownvaluesecond.toString());
                          // categoryId = newValue["categoryId"];
                          // print(categoryId = newValue["categoryId"]);
                          // this.categoryId=newValue(categoryId!);
                          // print(categoryIndex);
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              children: [
                                Text(
                                  locationValue,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, top: 1),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listData.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailsPage()));
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
                          Expanded(
                            child: Row(
                              children: [
                                //
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 11.0),
                                  // child: SizedBox(
                                  //   height: 90,
                                  //   width: 100,
                                  //   child: ClipRRect(
                                  //       borderRadius:
                                  //           BorderRadius.circular(12),
                                  //       child: Image.network(
                                  //         ApiConstants.imageUrl +
                                  //             listData[index]
                                  //                 .userImage
                                  //                 .toString(),
                                  //         fit: BoxFit.fill,
                                  //       )),
                                  // ),
                                  child: SizedBox(
                                    height: 90,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "${ApiConstants.imageUrl}${listData[index].userImage.toString()}",
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
                                        errorWidget:
                                            (context, url, error) =>
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
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0),
                                        child: Text(
                                          listData[index].name.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4.0,
                                          top: 7,
                                        ),
                                        child: Text(
                                          'General Contractors Contract',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 4.0),
                                            child: Row(children: [
                                              Text(
                                                "Rating:",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Text(
                                                "${listData[index].averageRating.toString()}.0",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                ),
                                              )
                                            ]),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              RatingBar.builder(
                                                initialRating:
                                                listData[index]
                                                    .averageRating
                                                    .toDouble(),
                                                minRating: 5,
                                                direction:
                                                Axis.horizontal,
                                                itemSize: 12,
                                                ignoreGestures: true,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemBuilder:
                                                    (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              Text(
                                                '(${listData[index].averageRating.toString()})',
                                                // overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Image.asset(
                          //   Images.pngWatsapp,
                          //   height: 30,
                          //   width: 30,
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  postFilterListApi(String category_id, String sub_category_id, String city,
      String sorting_type) async {
    if (city == 'selectCity'.tr()) {
      city = '';
    }
    if (sorting_type == 'sortBy'.tr()) {
      sorting_type = '';
    } else if (sorting_type == 'higherToLower'.tr()) {
      sorting_type = 'asc';
    } else {
      sorting_type = 'desc';
    }
    if (sub_category_id == 'null') {
      sub_category_id = '';
    }
    print(category_id);
    print(sub_category_id);
    print(city);

    print(sorting_type);
    var queryParameters = {
      'category_id': category_id,
      'sub_category_id': sub_category_id,
      'city': city,
      'sorting_type': sorting_type,
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.filterApiEndPoint)
        .replace(queryParameters: queryParameters);
    setState(() {
      isLoading = true;
    });
    var response = await http.post(url);
    if (response.statusCode == 200) {
      // success
      setState(() {
        isLoading = false;
      });
      var registerResponse =
      filterapimodelclass.fromJson(json.decode(response.body));
      if (registerResponse.status == true) {
        listData = registerResponse.result!;
        // SnackBarService.showSnackBar(
        //     context, registerResponse.message.toString());
      } else {
        SnackBarService.showSnackBar(
            context, registerResponse.message.toString());
      }
    }
  }
}
