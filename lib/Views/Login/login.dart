// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:bina_github/Views/ForgotPassword/forgot_password.dart';
import 'package:bina_github/Views/Login/Model/login_model.dart';
import 'package:bina_github/Views/Register/regsiter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../constants/color.dart';
import '../../constants/constants.dart';
import '../Dashboard/dashboard.dart';


void main() {
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _loginState();
  }
}

class _loginState extends State<Login> {
  Timer? _timer;

  // late double _progress;
  var loginData;

  @override
  void initState() {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CurvePainter(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100.0,
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset('assets/images/bina_logo.png'),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFF3D3D3D), //New
                          blurRadius: 25.0,
                          offset: Offset(0, 25))
                    ],
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Color(0xFF304803),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      LoginForm(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = ColorConst.buttonColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.5218750, size.height * 0.0315000,
        size.width * 0.9937500, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.9946875, size.height * 0.7455000,
        size.width * 0.9975000, size.height * 0.0120000);
    // path.lineTo(size.width*0.0012500,size.height*0.0020000);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? mtoken = " ";
  var user_type = '';
  var user_image = '';
  var website = '';
  var sinceYear = '';
  var membershipId = '';
  var isEditingProfile = false;

  postDataLoginUserOrCompany(
      String email,
      String password,
      String deviceId,
      ) async {
    var queryParameters = {
      'email': email,
      'password': password,
      'device_id': deviceId
    };
    setState(() {
      isEditingProfile = true;
    });
    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndPointUserCompany)
        .replace(queryParameters: queryParameters);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      setState(() {
        isEditingProfile = false;
      });
      // success
      var loginResponse =
      loginresponseModelClass.fromJson(json.decode(response.body));
      if (loginResponse.status == true) {
        setState(() {
          isEditingProfile = false;
        });
        //user logged in successfully
        SnackBarService.showSnackBar(context, loginResponse.result.toString());
        print("Congratulations!You logged In!");
        var result = loginResponse.data![0];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedin", true);
        prefs.setString("name", result.name.toString());
        prefs.setString("password", result.password.toString());
        prefs.setString("type", result.type.toString());
        prefs.setString("email", result.email.toString());
        prefs.setString("mobile", result.mobile.toString());
        prefs.setString("dob", result.dob.toString());
        prefs.setString("short_bio", result.shortBio.toString());
        prefs.setString('user_image', result.userImage.toString());
        prefs.setString("user_id", result.userId.toString());
        prefs.setString("city", result.city.toString());
        prefs.setString("register_id", result.registerId.toString());
        prefs.setString("website", result.website.toString());
        prefs.setString("since_year", result.sinceYear.toString());
        prefs.setString("membershipId", result.membershipId.toString());
        user_type = prefs.getString("type") ?? '';
        user_image = prefs.getString("user_image") ?? '';
        website = prefs.getString("website") ?? '';
        sinceYear = prefs.getString("since_year") ?? '';
        membershipId = prefs.getString("membershipId") ?? '';
        print('user type :${result.type.toString()}');
        print('usertype in get string shared preference :$user_type');
        print('user image in get string shared preference :$user_image');
        print('user website in get string shared preference :$website');
        print('user since year in get string shared preference :$sinceYear');
        print(
            'user membershipId in get string shared preference :$membershipId');
        var userData = loginResponse.data;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Dashboard(
                  userData: userData,
                )));
      } else {
        //wrong username/password
        SnackBarService.showSnackBar(context, loginResponse.result.toString());
      }
    } else {
      // show error
      SnackBarService.showSnackBar(context, 'oops! some error occurred :(');
    }
    print("responseData--->${response.body}");

    print("finalUrl--->$url");
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    var deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getToken();
  }

  // void requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true);
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('user authorized access granted');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('provisional access granted for user');
  //   } else {
  //     print('user denied access or permission');
  //   }
  // }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print(
          'my token is$mtoken',
        );
      });
      // saveToken(token!);
    });
  }

  // void saveToken(String token) async{
  //   await FirebaseFirestore.instance.collection("UserTokens").doc("User2").set({
  //     'token':token
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _emailController,
              autofillHints: const [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Enter your email"),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid email address';
                }
                if (!value.contains('@')) {
                  return 'Email is invalid';
                }
                return null;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _passwordController,
              cursorColor: Colors.black,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Enter Password"),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgotPasswordPage()));
                },
                child: const Text('Forgot password ?')),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF304803),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                  ),
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.

                    if (_formKey.currentState!.validate()) {
                      postDataLoginUserOrCompany(
                        _emailController.text.toString(),
                        _passwordController.text.toString(),
                        mtoken.toString(),
                      );
                    } else {
                      SnackBarService.showSnackBar(
                          context, 'wrong credentials,try again!');
                    }
                  },
                  child: isEditingProfile == true
                      ? SizedBox(
                      height: 45,
                      width: 45,
                      child: Center(child: CircularProgressIndicator()))
                      : const Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                )),
          ),
          Center(
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                const Center(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      'Do not have an account?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: const FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      'Register Now',
                      style: TextStyle(
                          color: Color(0xFF304803),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
