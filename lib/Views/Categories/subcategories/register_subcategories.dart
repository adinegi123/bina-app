import 'dart:convert';


import 'package:bina_github/Views/Categories/subcategories/Model/subcategory_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';

class RegisterSubCategoryPage extends StatefulWidget {
  final catId;

  const RegisterSubCategoryPage({Key? key, this.catId}) : super(key: key);

  @override
  State<RegisterSubCategoryPage> createState() =>
      _RegisterSubCategoryPageState();
}

class _RegisterSubCategoryPageState extends State<RegisterSubCategoryPage> {
  var isLoading = true;
  var subCategoryList = [];
  var isChecked = 0;

  // getSharedPrefrence() async{
  //   var catId=widget.catId;
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getSharedPrefrence();
    postgetSubCategory(widget.catId);
    print("we are in subcategory page & category id is-->${widget.catId}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Choose a Subcategory',
            ),
            backgroundColor: const Color(0xFF91C121),
            automaticallyImplyLeading: false),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          // shrinkWrap: true,
          itemCount: subCategoryList!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigator.popUntil(context, ModalRoute.withName('/registerRoute'));
                Navigator.of(context).pop(index + 1);
              },
              child: Card(
                child: ListTile(
                  tileColor:
                  isChecked == index ? Colors.green : Colors.white,
                  title: Text(
                      subCategoryList[index].subCategoryName.toString()),
                ),
              ),
            );
          },
        ));
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
      // subcategoryResponseStatus = getCategoryModelResponse.status;
      if (getCategoryModelResponse.result != null) {
        // subcategoryNameList = getCategoryModelResponse.message.toString();
        // print("sub category length${subcategoryNameList.length}");
        print("success--------------------------------------");
        subCategoryList = getCategoryModelResponse.result!;
      } else {
        print("failed--------------------------------------");
        print('something went wrong');
      }
    }
  }
}
