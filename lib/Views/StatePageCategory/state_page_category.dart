import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import 'Model/state_page_model.dart';

class StatePageCategory extends StatefulWidget {
  const StatePageCategory({Key? key, required data}) : super(key: key);

  @override
  State<StatePageCategory> createState() => _StatePageCategoryState();
}

var cityList = [];
var isChecked = 0;

class _StatePageCategoryState extends State<StatePageCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStateList();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xFF91C121),
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "selectCity".tr(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    isChecked = index;
                    final data = {
                      "name": cityList[index].name,
                      "Cityindex": index
                    };
                    Navigator.of(context).pop(data);
                  });
                },
                child: Card(
                  child: SizedBox(
                    height: 50,
                    child: ListTile(
                      tileColor:
                      isChecked == index ? Colors.green : Colors.white,
                      title: Center(child: Text(cityList[index].name)),
                    ),
                  ),
                ),
              );
            },
            itemCount: cityList.length,
            physics: BouncingScrollPhysics()),
      ),
    );
  }

  Future getStateList() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.stateNameEndpoint);

    var response = await http.get(url);
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var stateResponse = cityModelClass.fromJson(jsonDecode(response.body));
      if (stateResponse.status == true) {
        // print(stateResponse.result!.length.toString());
        cityList = stateResponse.result!;
        print("in select city page------>>>>>>>>>>>>>>${cityList[3].name!}");
      } else {
        print('error occurred while fetching list');
      }
    }
  }
}
