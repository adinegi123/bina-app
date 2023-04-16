import 'dart:convert';


import 'package:bina_github/Views/Profile/edit_profile.dart';
import 'package:bina_github/Views/Profile/model/delete_account_model.dart';
import 'package:bina_github/Widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../constants/images.dart';
import '../Login/login.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var isLoading = true;
  var user_id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    print('profile page--------------> user_id before setting value$user_id');
    user_id = myPref.getString("user_id").toString();
    print('profile page--------------> user_id before setting value$user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        elevation: 0.0,
        backgroundColor: Color(0xFF304803),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CircleAvatar(
              //     radius: 40,
              //     backgroundImage: NetworkImage(
              //         'https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg'),
              //   ),
              // ),
              // // Text('Sarah James',style: TextStyle(    color: Colors.black, fontWeight: FontWeight.w500,fontSize: 17),),
              //

              const SizedBox(
                height: 40,
              ),
              _footer()
            ],
          ),
        ),
      ),
    );
  }

  Widget _reusable_listTile(String ImageUrl, String category) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          ImageUrl,
          height: 25,
          width: 10,
          color: Colors.black,
        ),
        title: Text(
          category,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditProfilepage()));
            },
            child: _reusable_listTile(Images.jpgDetails, 'editProfile'.tr())),
        InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => PrivacyPolicyPage()));
          },
          child: _reusable_listTile(
              Images.jpgDetails, 'privacyPolicy'.tr().toLowerCase()),
        ),
        // _reusable_listTile(Images.jpgDetails, 'shareMembershipId'.tr()),
        InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: AlertDialog(
                          title: Text(
                            "deleteAccountQuestion".tr(),
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              child: Text("deleteAccount".tr()),
                              onPressed: () async {
                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                deleteAccount(user_id);
                                await pref.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Login(),
                                  ),
                                      (route) => false,
                                );
                              },
                            ),
                            TextButton(
                              child: Text("cancel".tr()),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                          ],
                        ));
                  });
            },
            child: _reusable_listTile(Images.jpgDetails, 'deleteAccount'.tr())),
        // _reusable_listTile(Images.jpgDetails, 'inviteFriends'.tr()),
        GestureDetector(
            onTap: () {
              logout(context);
            },
            child: _reusable_listTile(Images.jpgDetails, 'logout'.tr())),
      ],
    );
  }

  logout(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Logout"),
      onPressed: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ),
              (route) => false,
        );
      },
    );
    Widget noButton = TextButton(
      child: Text("cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );

    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert !"),
          content: Text("are you sure you want to logout ?"),
          actions: [
            okButton,
            noButton,
          ],
        );
      },
    );
  }

  Future deleteAccount(var user_id) async {
    setState(() {
      isLoading = true;
    });
    var queryparameters = {"user_id": user_id};
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.deleteAccountEndPoint)
        .replace(queryParameters: queryparameters);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responsee = deleteaccountModel.fromJson(json.decode(response.body));
      // modelstatusrespnse=responsee.toString();
      // print(modelstatusrespnse);
      if (responsee.status == true) {
        if (mounted)
          setState(() {
            isLoading = false;
            // subcategoryNameList = responsee["result"];
            print(responsee.message);
            SnackBarService.showSnackBar(context, responsee.message.toString());
          });
      }
      //
      // print(response.body);
      // print("sub category length${subcategoryNameList.length}");
    } else {
      setState(() {
        isLoading = false;
      });
      print('something went wrong');
    }
  }
}
