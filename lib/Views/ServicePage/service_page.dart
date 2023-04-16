import 'dart:convert';


import 'package:bina_github/constants/images.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../Categories/category_details.dart';

class ServicePage extends StatefulWidget {
  final var1;
  final title;

  const ServicePage({Key? key, this.var1, this.title}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // postgetSubCategory();//global
    postgetSubCategory(widget.var1.toString());
  }

  var isLoading = false;
  var subcategoryNameList = [];
  var modelstatusrespnse = '';

  @override
  Widget build(BuildContext context) {
    //local
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
          ),
          title: Text(widget.title.toString()),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xFF304803),
        ),
        body: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              subcategoryNameList.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subcategoryNameList.length,
                  itemBuilder: (context, index) {
                    // List titles = [
                    //   'Consultants',
                    //   'Contractors',
                    //   'Suppliers',
                    //   'Real Estate',
                    //   'Services',
                    //   'Maintenance',
                    //   'Jobs',
                    //   'Lawyers & Arbritaries',
                    //   'Bids',
                    // ];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CategoryDetailsPage(
                                    var1: widget.var1,
                                    var2: index + 1,
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(0, .1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      Image.asset(Images.pngServices),
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                subcategoryNameList[index]
                                ["sub_category_name"]
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ));
                  })
                  : Container()
            ],
          ),
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
      //var getCategoryModelResponse =
      //subcategoryModelClass.fromJson(jsonDecode(response.body));
      var responsee = json.decode(response.body);
      modelstatusrespnse = responsee["status"].toString();
      print(modelstatusrespnse);
      if (responsee["status"] == 1) {
        setState(() {
          isLoading = false;
          subcategoryNameList = responsee["result"];
        });
      }

      print(response.body);
      print("sub category length${subcategoryNameList.length}");
    } else {
      setState(() {
        isLoading = false;
      });
      print('something went wrong');
    }
  }
}
