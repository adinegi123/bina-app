import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bina_github/Views/Categories/subcategories/Model/subcategory_model.dart';
import 'package:bina_github/Views/Categories/subcategories/register_subcategories.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



import 'package:http/http.dart' as http;

import '../../apis/api_services.dart';
import '../../constants/constants.dart';
import 'Model/category_model.dart';

var isChecked = 0;
Timer? timer;
List<bool>? _selected = null;
String? subCatResponse = null;
List<bool>? isSubCategorySelected = null;
List<dynamic>? subCatResult = null;
bool? isSubLoaded = false;
int? subCatCount = 0;
List<String>? sub_cat;
bool isLoading = true;

class CatSubCatModel {
  String? cate_id = null;
  SubCateModel? subCatModel = null;

  CatSubCatModel(String cat_id, List<String>? subCateModel) {
    this.category_id = cat_id;
    this.sub_cat = subCateModel;
  }

  set sub_cat(List<String>? sub_cat) {}

  set category_id(String category_id) {}
}

class SubCateModel {
  String? sub_category_id = null;

  SubCateModel(String sub_cat_id) {
    this.sub_category_id = sub_cat_id;
  }
}

class Category extends StatefulWidget {
  static List<CatSubCatModel> cat_sub_cat_id = <CatSubCatModel>[];

  // final String? categoryid;

  const Category({Key? key, var data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {

    return CategoryState();

  }
}

class CategoryState extends State<Category> {
  var isLoaded = false;
  CategoryModel? _categories = null;
  var count = 0;
  final _pageController = PageController();
  var catId = '';
  var resultList = [];
  var subcategory_Id = '';
  var value = '';

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() async {
    _categories = (await ApiService().getCategory())!;
    if (_categories != null) {
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
        isLoaded = true;
        count = _categories!.result.length;
        _selected = List.generate(_categories!.result.length, (i) => false);
        Category.cat_sub_cat_id = <CatSubCatModel>[];
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF91C121),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(color: Color(0xFF91C121)),
        ),
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            // _pageController.addListener(() {
            //     setState((){
            //         isChecked = isChecked!;
            //     });
            // });
            return Card(
              child: ListTile(
                tileColor: isChecked == index ? Colors.green : null,
                title: Text(_categories!.result[index].categoryName),
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child:
                  Image.network(_categories!.result[index].categoryImage),
                ),
                onTap: () async {
                  setState(() {
                    // _selected![index] = !_selected![index]
                    isChecked = index;
                    catId = _categories!.result[index].categoryId;
                    value = _categories!.result[index].categoryName;

                    final subcategoryId = subcategory_Id;
                    postgetSubCategory(_categories!.result[index].categoryId);

                    // Navigator.of(context).pop(data);
                    // postgetSubCategory(catId);

                    ///new
                    ///debugger
                  });

                  if (_selected![index]) {
                    // subCategory(context,_selected![index],_categories!.result[index].categoryId, _categories!.result[index].categoryName);

                    var formData = FormData.fromMap(
                        {"category_id": _categories!.result[index].categoryId});

                    subCatResponse =
                    (await ApiService().get_sub_category(formData))!;
                    if (subCatResponse != null) {
                      isSubLoaded = true;
                      Map<String, dynamic> sub_category_data =
                      jsonDecode(subCatResponse!);

                      if (sub_category_data['status'] == 1) {
                        subCatResult?.clear();
                        isSubCategorySelected?.clear();
                        subCatResult = sub_category_data['result'];

                        isSubCategorySelected =
                            List.generate(subCatResult!.length, (i) => false);
                        subCatCount = subCatResult!.length;
                        sub_cat = <String>[];
                      }
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0))),
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(top: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      _categories!.result[index].categoryName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF91C121)),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 2.0),
                                  child: const Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'select sub categories',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: subCatCount,
                                  itemBuilder:
                                      (BuildContext context, int sub_index) {
                                    Map<String, dynamic> res_data =
                                    subCatResult![sub_index];
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter setState) {
                                      return Center(
                                        child: CheckboxListTile(
                                          title: Text(
                                              res_data['sub_category_name']),
                                          value:
                                          isSubCategorySelected![sub_index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isSubCategorySelected![
                                              sub_index] = value!;
                                              print(
                                                  res_data["sub_category_id"]);
                                              sub_cat?.add(
                                                  res_data["sub_category_id"]);
                                            });
                                          },
                                        ),
                                      );
                                    });
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        18.0),
                                                    side: const BorderSide(
                                                        color: Colors.red)))),
                                        onPressed: () {
                                          Category.cat_sub_cat_id!.add(
                                              CatSubCatModel(
                                                  _categories!
                                                      .result[index].categoryId,
                                                  sub_cat));
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            );
          },
        ),
      ),
    );
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

      if (getCategoryModelResponse.result != null) {
        resultList = getCategoryModelResponse.result!;
        print("success--------------------------------------");
        final newValue = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterSubCategoryPage(
                catId: catId,
              ),
            ));

        final data = {
          "value": value,
          "categoryId": catId,
          "subCategoryId": newValue,
        };
        Navigator.of(context).pop(data);

        print("value--->" + newValue.toString());

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => RegisterSubCategoryPage(
        //               catId: catId,
        //             )));
      } else {
        final data = {"value": value, "categoryId": catId};
        Navigator.of(context).pop(data);
      }
    }
  }
}
