import 'package:bina_github/Views/Login/login.dart';
import 'package:flutter/material.dart';



class AfterForgotPasswordPage extends StatelessWidget {
  const AfterForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Password sent on your e-mail',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    'Please check and ',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Login()),
                                (route) => false);
                      },
                      child: Text(
                        'login again',
                        style: TextStyle(color: Colors.green),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
