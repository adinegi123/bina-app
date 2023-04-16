import 'dart:convert';

import 'package:bina_github/Views/Jobs/select_jobs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../Widgets/solid_button.dart';
import '../../Widgets/text_form_field.dart';
import '../../constants/constants.dart';
import '../StatePageCategory/state_page_category.dart';
import 'Model/apply_for_job.dart';

class AddaVaccancyPage extends StatefulWidget {
  const AddaVaccancyPage({Key? key}) : super(key: key);

  @override
  State<AddaVaccancyPage> createState() => _AddaVaccancyPageState();
}

class _AddaVaccancyPageState extends State<AddaVaccancyPage> {
  bool isLoading = true;
  var jobTypes = [];
  String? jobs;
  var cityName;
  var JobType;
  var JobId;
  var user_id = '';
  var value = 'Select Jobs';
  var job_Id;
  var locationValue = 'Location';
  bool isJobSelected = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController minimumExperienceController = TextEditingController();
  TextEditingController salaryRangeController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController rolesAndresponsibilitiesController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  getSharedPreference() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      print("before get ${user_id}");
      user_id = myPref.getString("user_id") ?? "";
      print("after get ${user_id}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add vaccancy'),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   child:
              //       Center(child: Text('User Details(AutoFill(Usr or company))')),
              // ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'title::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: titleController,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'location::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: false,
                replacement: Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: const Color(0xFFD3D3D3),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      final newValue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatePageCategory(data: cityName),
                          ));

                      setState(() {
                        locationValue = newValue["name"];
                        print(
                            "cityname recieved ------------------->>>>>>>>>>>>>>>>>>>${cityName.toString()}");
                        print(
                            "new value recieved ------------------->>>>>>>>>>>>>>>>>>>${newValue.toString()}");
                        // categoryId = newValue["categoryId"];
                        // print(categoryId = newValue["categoryId"]);
                        // this.categoryId=newValue(categoryId!);
                        // print(categoryIndex);
                      });
                    },
                    child: Text(locationValue),
                  ),
                ),
                child: TextFormField(
                  cursorColor: Colors.black,

                  decoration: const InputDecoration(hintText: "location"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select location';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'looking to Hire ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Visibility(
                visible: false,
                replacement: Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: const Color(0xFFD3D3D3),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      final newValue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectJobTypesPage(data: JobType),
                          ));

                      setState(() {
                        value = newValue["value"];
                        job_Id = newValue["jobId"];

                        print(
                            "value recieved---------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>${value.toString()}");
                        print(
                            "job_Id recieved------------->${job_Id.toString()}");
                        print(
                            "new value recieved--------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${newValue.toString()}");
                        // categoryId = newValue["categoryId"];
                        // print(categoryId = newValue["categoryId"]);
                        // this.categoryId=newValue(categoryId!);
                        // print(categoryIndex);
                      });
                    },
                    child: Text(value),
                  ),
                ),
                child: TextFormField(
                  cursorColor: Colors.black,

                  decoration: const InputDecoration(hintText: "Category"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select jobtype';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'minimum experience(years) ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  controller: minimumExperienceController,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'minimum experience is required';
                    }
                    return null;
                  },
                  hintText: '',
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Salary range ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: salaryRangeController,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'salary range is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Job Description ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: jobDescriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Roles & responsibilities ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: rolesAndresponsibilitiesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                ),
              ),
              InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate())
                      postAddVaccancy(
                        user_id,
                        titleController.text.toString(),
                        locationValue.toString(),
                        job_Id.toString(),
                        salaryRangeController.text.toString(),
                        jobDescriptionController.text.toString(),
                        rolesAndresponsibilitiesController.text.toString(),
                      );
                    print(
                        "inside post vaccancy api job id value ----------------->>>>>>>>>>>>>>>>>${job_Id.toString()}");
                  },
                  child: reusableSolidButton('Post Vacancy'))
            ],
          ),
        ),
      ),
    );
  }

  Widget commontextWidget(
      String text, int maxlines, TextInputType? textInputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: MyTextFormField(
                hintText: '',
                maxLines: maxlines,
                keyboardType: textInputType,
              ),
            ),
          ],
        ),
      ],
    );
  }

  postAddVaccancy(
      String user_id,
      String job_title,
      String location,
      String jobs_type,
      String salary_range,
      String job_description,
      String roles_responsibility,
      ) async {
    var queryParameters = {
      'user_id': user_id,
      'job_title': job_title,
      'location': location,
      'jobs_type': jobs_type,
      'salary_range': salary_range,
      'job_description': job_description,
      'roles_responsibility': roles_responsibility,
    };
    // var request = http.MultipartRequest('POST', uri)

    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.PostVaccancyEndPoint)
        .replace(queryParameters: queryParameters);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      isLoading = false;
      // success

      print(response);

      var addVaccancyResponse =
      applyForJobUserModel.fromJson(json.decode(response.body));
      if (addVaccancyResponse.status == true) {
        SnackBarService.showSnackBar(
            context, addVaccancyResponse.message.toString());
        Navigator.pop(context);
        print("Congratulations!User Information saved!");
        // print(user_id);
        // print(titleController.text.toString());
        // print(locationValue.toString());
        // print(job_Id.toString());
        // print(salaryRangeController.text.toString());
        // print(jobDescriptionController.text.toString());
        // print(rolesAndresponsibilitiesController.text.toString());
      } else {
        print('error');
      }
    }
    // print("responseData--->${response.body}");
    // print("finalUrl--->$url");
  }
}
