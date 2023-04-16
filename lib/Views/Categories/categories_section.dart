import 'dart:convert';

import 'package:bina_github/Views/Categories/categories_item_ile.dart';
import 'package:bina_github/Views/Categories/subcategories/Model/subcategory_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../apis/api_services.dart';
import '../../constants/constants.dart';
import '../Bids/Pages/bid_page.dart';
import '../Dashboard/dashboard.dart';
import '../Jobs/jobs_page.dart';
import '../ServicePage/service_page.dart';
import 'Model/category_model.dart';
import 'category_details.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _categorieState();
  }
}

class _categorieState extends State<CategoriesSection> {
  // List dashBoardServicesList = [
  //
  //   Images.pngnewContractor,
  //   Images.pngSupplier,
  //   Images.pngnewRealEstate,
  //   Images.pngnewServices,
  //   Images.pngnewMaintenance,
  //   Images.pngnewJobs,
  //   Images.pngLawyeyrs,
  //   Images.pngnewBids,
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // postgetSubCategory(ApiService().getCategory());
    // postgetSubCategory();
  }

  var subcategoryNameList;
  var subcategoryResponseStatus = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getCategory(),
        builder: (BuildContext ctx, AsyncSnapshot<CategoryModel?> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            count = snapshot.data?.result.length;
            return GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 3,
              // Generate 100 widgets that display their index in the List.
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              children: List.generate(count!, (index) {
                final Color color =
                Colors.primaries[index % Colors.primaries.length];
                return GestureDetector(
                    onTap: () {
                      if (true) {
                        print(
                            "subcategoryResponseStatus inside if-------------------->>>>>$subcategoryResponseStatus");
                        if (index == 0 || index == 7) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CategoryDetailsPage(var1: snapshot
                                      .data!.result[index].categoryId,)));
                        } else if (index == 6) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => JobsPage()));
                        } else if (index == 8) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => BiddingPage()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ServicePage(
                                      var1: snapshot
                                          .data!.result[index].categoryId,
                                      title: snapshot
                                          .data!.result[index].categoryName)));
                        }
                      }
                    },
                    child: ItemTile(
                      index,
                      snapshot.data!.result[index].categoryName,
                      snapshot.data!.result[index].categoryImage,
                    ));
              }),
            );
          }
        });
  }

  Future postgetSubCategory(var categoryId) async {
    setState(() {
      isLoading = true;
    });
    var queryparameters = {"category_id": categoryId.toString()};
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.subCategoryEndPoint)
        .replace(queryParameters: queryparameters);
    var response = await http.post(url);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(response.body);
      var getCategoryModelResponse =
      subcategoryModelClass.fromJson(jsonDecode(response.body));
      subcategoryResponseStatus = getCategoryModelResponse.status;
      if (getCategoryModelResponse.status == 1) {
        subcategoryNameList = getCategoryModelResponse.message.toString();
        // print("sub category length${subcategoryNameList.length}");
        print("success--------------------------------------");
        // } else {
        //   setState(() {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (_) => CategoryDetailsPage()));
        //   });
        // }
      } else {
        print("failed--------------------------------------");
        setState(() {
          isLoading = false;
        });
        print('something went wrong');
      }
    }
  }
}
