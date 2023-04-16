import 'dart:convert';


import 'package:bina_github/Views/ForgotPassword/Model/forgot_password_model.dart';
import 'package:bina_github/Views/ForgotPassword/after_forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../Widgets/solid_button.dart';
import '../../constants/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF304803),
        centerTitle: true,
        title: Text('Forgot Password'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Enter E-mail Address",
              style: TextStyle(fontSize: 14, color: Color(0xFF304803)),
            ),
            ForgotPassForm(),
          ],
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  var isEditingProfile = false;

  postForgotPassword(String email) async {
    var queryParameters = {"email": email};
    setState(() {
      isEditingProfile = true;
    });
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.sendNewPasswordEndPoint)
        .replace(queryParameters: queryParameters);
    var response = await http.post(url);
    if (response.statusCode == 200) {
      setState(() {
        isEditingProfile = false;
      });
      var forgotPasswordResponse =
      forgotPassswordModel.fromJson(jsonDecode(response.body));
      if (forgotPasswordResponse.message == 'success') {
        setState(() {
          isEditingProfile = false;
        });
        SnackBarService.showSnackBar(
            context, forgotPasswordResponse.result.toString());
        SnackBarService.showSnackBar(context, 'this might take a minute');
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => AfterForgotPasswordPage()));
      } else {
        SnackBarService.showSnackBar(
            context, forgotPasswordResponse.result.toString());
      }
    }
  }

  var user_id;
  var password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextFormField(
                cursorColor: Colors.black,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
                decoration: new InputDecoration(hintText: "Email"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value!)) {
                    return 'Please enter a valid email address';
                  }
                  if (!value.contains('@')) {
                    return 'Email is invalid';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    postForgotPassword(emailController.text.toString());
                  }
                },
                child: isEditingProfile == true
                    ? SizedBox(
                    height: 45,
                    width: 45,
                    child: Center(child: CircularProgressIndicator()))
                    : reusableSolidButton('Send verification code'))
          ],
        ));
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      user_id = myPref.getString("user_id") ?? '';
      password = myPref.getString("password") ?? '';
    });
  }
}
