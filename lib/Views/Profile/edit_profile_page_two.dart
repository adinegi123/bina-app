import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bina_github/Views/Profile/model/profile_update_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Widgets/snackbar.dart';
import '../../Widgets/solid_button.dart';
import '../../Widgets/text_form_field.dart';
import '../../constants/constants.dart';

class EditprofilePageTwo extends StatefulWidget {
  const EditprofilePageTwo({Key? key}) : super(key: key);

  @override
  State<EditprofilePageTwo> createState() => _EditprofilePageTwoState();
}

class _EditprofilePageTwoState extends State<EditprofilePageTwo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController sinceyearController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  // final user = UserPreferences.myUserProfile;
  var registerType = false;
  var isEditingProfile = false;

  var fileToSend;
  var jobs_type = '';

  var register_id = '';
  var sinceyear = '';
  var website = '';
  var Username = '';
  final _formKey = GlobalKey<FormState>();

  // File? _file;
  File? fileToDisplay = File('');
  var user_id;
  var user_image;
  var image;
  var city = '';
  var user_type = '';
  bool visibility = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
    // print("user image in init :$user_image");
    // print(bioController.text);
  }

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;

  // File? _file;

  Future pickFile(String? fileName) async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'svg']);
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

  Future<void> updateProfilesecond(
      String? user_id,
      String? name,
      String? email,
      String? short_bio,
      String? mobile,
      String? sinceyear,
      String? website,
      File _image) async {
    setState(() {
      isEditingProfile = true;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.updateandSaveUserProfile));

    // Add the name field to the request

    request.fields['user_id'] = user_id.toString();
    request.fields['name'] = nameController.text.toString();
    request.fields['email'] = emailController.text.toString();
    request.fields['short_bio'] = bioController.text.toString();
    request.fields['mobile'] = noController.text.toString();
    request.fields['sinceyear'] = sinceyearController.text.toString();
    request.fields['website'] = websiteController.text.toString();

    print(user_id.toString());
    print(name.toString());
    print(email.toString());
    print(short_bio.toString());
    print(mobile.toString());
    print(
        "since year at api calling------------------------>${sinceyear.toString()}");
    print(
        'since year at api calling------------------------>${website.toString()}');
    print("user image --------------->${user_image.toString()}");
    print("file to send ${fileToSend.toString()}");
    print("picked file ${pickedFile.toString()}");

    // Add the profile picture file to the request
    if (_image != null) {
      var stream = new http.ByteStream(Stream.castFrom(_image.openRead()));
      var length = await _image.length();
      var multipartFile = new http.MultipartFile('user_image', stream, length,
          filename: _image.path.toString());
      request.files.add(multipartFile);
    }

    // Set the headers for the request
    request.headers['Content-Type'] = 'multipart/form-data';

    // Send the request and get the response
    var response = await request.send();
    setState(() {});

    // Handle the response
    if (response.statusCode == 200) {
      setState(() {
        isEditingProfile = false;
      });
      print(response.statusCode);
      print(response);
      // Profile updated successfully
      // Parse the response data if necessary

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var insideresponse =
          profileUpdateModelClass.fromJson(json.decode(responseString));

      // user_image=insideresponse.data!.userImage.toString();

      if (insideresponse.message == 'success') {
        setState(() {
          isEditingProfile = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(
            "user_image", insideresponse.data!.userImage.toString());
        SnackBarService.showSnackBar(context, insideresponse.result.toString());

        print(
            "inside profile api-------->>>>>>>>>>>>>since year controller has some value->>>${sinceyearController.text.toString()}");
        prefs.setString('since_year', sinceyearController.text.toString());
        prefs.setString('website', websiteController.text.toString());
        prefs.setString("name", nameController.text.toString());
        prefs.setString("email", emailController.text.toString());
        prefs.setString("mobile", noController.text.toString());
        prefs.setString("short_bio", bioController.text.toString());
        Navigator.pop(context);
      } else {
        setState(() {
          isEditingProfile = false;
        });
        //SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString(
        //     "user_image", insideresponse.data!.userImage.toString());
        // SnackBarService.showSnackBar(context, insideresponse.result.toString());
        Navigator.pop(context);
      }

      var responseJson = json.decode(responseString);
      print(
          "------------------------>>>>>>>>>>>>>>>>>>>>>>>>user image after api response-------->${insideresponse.data!.userImage.toString()}");
      print(
          "------------------------>>>>>>>>>>>>>>>>>>>>>>>>since year after api response-------->${insideresponse.data!.sinceYear.toString()}");
      print(
          "------------------------>>>>>>>>>>>>>>>>>>>>>>>>website after api response----------->${insideresponse.data!.website.toString()}");
    } else {
      // Handle the error
      print('Error updating profile: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      String? _fileName;
                      pickFile(_fileName);
                    },
                    child: pickedFile != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: Image.file(fileToDisplay!).image)
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: Image.network(
                                    ApiConstants.imageUrl +
                                        user_image.toString())
                                .image),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    'fullName'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: MyTextFormField(
                    hintText: '',
                    controller: nameController,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    'email'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: MyTextFormField(
                    hintText: '',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    'contact'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: MyTextFormField(
                    hintText: '',
                    controller: noController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact';
                      }
                      return null;
                    },
                  ),
                ),
                user_type == 'company'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(
                          'website'.tr(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                user_type == 'company'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: MyTextFormField(
                          hintText: '',
                          controller: websiteController,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter website';
                            }
                            return null;
                          },
                        ),
                      )
                    : Container(),
                user_type == 'company'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(
                          'since'.tr(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                user_type == 'company'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: MyTextFormField(
                          hintText: '',
                          controller: sinceyearController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter year';
                            }
                            return null;
                          },
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    'bio'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: MyTextFormField(
                    hintText: '',
                    controller: bioController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description/bio';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
          onTap: () {
            // uploadAssignmentApi(
            //     user_id: user_id.toString(),
            //     email: emailController.text.toString(),
            //     mobile: noController.text.toString(),
            //     name: nameController.text.toString(),
            //     short_bio: bioController.text.toString(),
            //     file: fileToSend);
            //
            // uploadImage();
            // postDateUpdateUserProfile(
            //     user_id.toString(),
            //     nameController.text.toString(),
            //     fileToSend.toString(),
            //     emailCotroller.text.toString(),
            //     bioController.text.toString(),
            //     noController.text.toString());
            updateProfilesecond(
                user_id.toString(),
                nameController.text.toString(),
                emailController.text.toString(),
                bioController.text.toString(),
                noController.text.toString(),
                sinceyearController.text.toString(),
                websiteController.text.toString(),
                fileToSend);
          },
          child: isEditingProfile == true
              ? SizedBox(
                  height: 45,
                  width: 45,
                  child: Center(child: CircularProgressIndicator()))
              : reusableSolidButton('save'.tr())),
    );
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      nameController.text = myPref.getString("name") ?? '';
      emailController.text = myPref.getString("email") ?? '';
      user_image = myPref.getString("user_image") ?? "";
      noController.text = myPref.getString("mobile") ?? '';
      bioController.text = myPref.getString("short_bio") ?? '';
      city = myPref.getString("city") ?? '';
      jobs_type = myPref.getString("jobs_type") ?? '';
      user_type = myPref.getString("type") ?? '';
      register_id = myPref.getString("register_id") ?? '';
      Username = myPref.getString("name") ?? '';
      sinceyear = myPref.getString("since_year") ?? '';
      website = myPref.getString("website") ?? '';
      sinceyearController.text = myPref.getString("since_year") ?? '';
      websiteController.text = myPref.getString("website") ?? '';

      print('city after setting$city');
      print('jobs_type after setting$jobs_type');
      print('user_type from login :=====>$user_type');
      print('register_id from login$register_id');
      print('Username from login--------------->$Username');
      print('user image from login--------------->$user_image');
      print('sinceyear from login model --------------->$sinceyear');
      print('website from login model--------------->$website');
      print('_userType from login model--------------->$user_type');
    });
  }

  Widget commonFieldWidget(
      String text, int maxlines, TextInputType textInputType, controller) {
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
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                controller: controller,
                keyboardType: textInputType,
                onTextChange: (onTextChange) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
