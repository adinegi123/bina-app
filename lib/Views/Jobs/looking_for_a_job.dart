import 'dart:convert';
import 'dart:io';

import 'package:bina_github/Views/Jobs/select_jobs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import '../../Widgets/snackbar.dart';
import '../../Widgets/solid_button.dart';
import '../../Widgets/text_form_field.dart';
import '../../apis/api_services.dart';
import '../../constants/constants.dart';
import '../StatePageCategory/state_page_category.dart';
import 'Model/applyforjob.dart';

class LookingForAJobPage extends StatefulWidget {
  const LookingForAJobPage({Key? key}) : super(key: key);

  @override
  State<LookingForAJobPage> createState() => _LookingForAJobPageState();
}

class _LookingForAJobPageState extends State<LookingForAJobPage> {
  File? _file;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController totalExperienceController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();
  var cityName;
  var locationValue = 'Location';
  var value = 'Select Jobs';
  var JobType;
  var Job_Id;
  var user_image;
  var user_id = '';
  var name = '';
  var email = '';
  var contact = '';
  var fileToSend;
  var city = '';
  var total_experience_year = '';
  var expected_salary = '';
  var qualification = '';

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;

  // File? _file;
  File? fileToDisplay;

  Future pickFile(String? fileName) async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf']);

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        fileToDisplay = File(result!.files.first.path!);
        fileToSend = File(result!.files.single.path!);
        print('File-name:${_fileName}');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  uploadAssignmentApi(
      {String? user_id,
        String? jobs_type,
        String? total_experience_month,
        String? expected_salary,
        String? qualification,
        String? location,
        File? file}) async {
    Map param = {
      'user_id': user_id,
      'jobs_type': jobs_type,
      'total_experience_month': total_experience_month,
      'expected_salary': expected_salary,
      'qualification': qualification,
      'location': location,
    };

    var response = await callUploadAssignmentApi(param, file!);
    print(user_id);
    print(jobs_type);
    print(total_experience_month);
    print(expected_salary);
    print(qualification);
    print(location);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("city", locationValue);
    prefs.setString("jobs_type_apply_id", Job_Id);
    print("jobs_type id=======================>${jobs_type.toString()}");
    prefs.setString(
        "total_experience_year", totalExperienceController.text.toString());
    prefs.setString("qualification", qualificationController.text.toString());
    prefs.setString(
        "expected_salary", expectedSalaryController.text.toString());
    // prefs.setString("resume",value);
    print('location------------>$locationValue');
    print('jobs_type_apply_id------------->$jobs_type');
    jobs_type = prefs.getString("jobs_type_apply_id") ?? '';
    print(
        'jobs_type_apply_id after setting finally...........................$jobs_type');

    isLoading = false;
    var applyForJobResponseModel = applyforJobModelClass.fromJson(response);
    if (applyForJobResponseModel.status == true) {
      print(
          'inside model class multipart>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      SnackBarService.showSnackBar(
          context, applyForJobResponseModel.message.toString());

      // print('jobs_type');

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool("isLoggedin", true);
      // prefs.setString("name", result['name']);
    }
    // print(response);
    // print(applyForJobResponseModel.status);

    setState(() {});
  }

  Future<dynamic> callUploadAssignmentApi(Map parameter, File file) async {
    final response = await ApiService().postAfterAuthMultiPart(
        parameter,
        file,
        ApiConstants.baseUrl + ApiConstants.applyForJobEndPoint,
        context,
        'resume');

    return response;
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();

    print("user_id before setting: $user_id");
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      name = myPref.getString("name") ?? '';
      email = myPref.getString("email") ?? '';

      contact = myPref.getString("mobile") ?? '';
      city = myPref.getString("city") ?? '';
      totalExperienceController.text =
          myPref.getString("total_experience_year") ?? '';
      qualificationController.text = myPref.getString("qualification") ?? '';
      expectedSalaryController.text = myPref.getString("expected_salary") ?? '';
      print("user_id after setting : $user_id");
      print("name after setting : $name");
      print("email after setting : $email");
      print("contact after setting : $contact");
      // print("total_experience_year after setting : $total_experience_year");
      // print("qualification after setting : $qualification");
      // print("expected_salary after setting : $expected_salary");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply For Job'),
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Name ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(name),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'E-mail ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(email),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Contact-no ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(contact),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'location:(Autofill)::',
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
                  'looking to Work on :',
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
                        Job_Id = newValue["jobId"];
                        print(
                            "in apply for job vaccancy page-------------------------->>>>>>>>>job Id is--->${Job_Id.toString()}");
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
                  'Total experience(years) ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: totalExperienceController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter experience';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Qualifications ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: qualificationController,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your qualifications';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Expected Salary ::',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: MyTextFormField(
                  hintText: '',
                  controller: expectedSalaryController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter salary';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                child: Text(
                  'Attach CV :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                  onTap: () async {
                    String? _fileName;
                    pickFile(_fileName);
                    // final result = await FilePicker.platform
                    //     .pickFiles(allowMultiple: false);
                    // if (result == null) return;
                    // final file = result.files.first;
                    // if (kDebugMode) {
                    //   print(file);
                    // }
                  },
                  child: Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          Center(child: Text(' ')),
                          if (pickedFile != null)
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Color(0xFF304803)),
                                child: (Text(
                                  _fileName!,
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                        ],
                      ))),
              InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // applyForAJob(
                      //   '12',
                      //   'resume',
                      //   value.toString(),
                      //   totalExperienceController.text.toString(),
                      //   expectedSalaryController.text.toString(),
                      //   qualificationController.toString(),
                      //   locationValue.toString(),
                      // );

                      // SharedPreferences myPref = await SharedPreferences.getInstance();
                      // setState(() {
                      //   print('user id before upload asssignment call(in set state) $user_id');
                      //   user_id = myPref.getString("user_id") ?? "";
                      //   print('user id during upload asssignment call (in set state)$user_id');
                      //
                      //
                      // });
                      uploadAssignmentApi(
                          user_id: user_id.toString(),
                          jobs_type: Job_Id.toString(),
                          total_experience_month:
                          totalExperienceController.text.toString(),
                          expected_salary:
                          expectedSalaryController.text.toString(),
                          qualification:
                          qualificationController.text.toString(),
                          location: locationValue.toString(),
                          file: File(result!.files.single.path!));
                    }
                  },
                  child: reusableSolidButton('Save your job profile'))
            ],
          ),
        ),
      ),
    );
  }

  Column commontextWidget(
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

  applyForAJob(
      String user_id,
      String resume,
      String jobs_type,
      String total_experience_month,
      String expected_salary,
      String qualification,
      String location,
      ) async {
    var queryParameters = {
      'user_id': user_id,
      'resume': resume,
      'jobs_type': jobs_type,
      'total_experience_month': total_experience_month,
      'expected_salary': expected_salary,
      'qualification': qualification,
      'location': location,
    };
    // var request = http.MultipartRequest('POST', uri)

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.applyForJobEndPoint)
        .replace(queryParameters: queryParameters);
    setState(() {
      isLoading = true;
    });
    var response = await http.post(url);
    if (response.statusCode == 200) {
      print("status after decoding${response.statusCode}");
      // success
      setState(() {
        isLoading = false;
      });
      print(response);
      print(response.body);
      var applyJobResponse =
      applyforJobModelClass.fromJson(json.decode(response.body));
      print("status after decoding:${applyJobResponse.status}");
      if (applyJobResponse.status == 200) {
        print(applyJobResponse.message);
      } else {
        print(applyJobResponse.message);
      }

      // if(response.body.isNotEmpty) {
      // var responsee=   applyforJobModelClass.fromJson(json.decode(response.body));
      //   print(responsee.status);
      // print(responsee.message); print(responsee.data);
      // }

      // var applyforJobResponse =
      //     applyforJobModelClass.fromJson(json.decode(response.body));
      // if (applyforJobResponse.status == true) {
      //
      //   print(applyforJobResponse);
      //
      //   SnackBarService.showSnackBar(
      //       context, applyforJobResponse.message.toString());
      //   print("Congratulations!User Information saved!");
      //   print(user_id);
      //   print(nameController.text.toString());
      //   print(locationValue.toString());
      //   print(value.toString());
      //   print(expectedSalaryController.text.toString());
      //   print(qualificationController.text.toString());
      // } else {
      //   SnackBarService.showSnackBar(
      //       context, applyforJobResponse.message.toString());
      // }
    }
    // print("responseData--->${response.body}");
    // print("finalUrl--->$url");
  }
}
