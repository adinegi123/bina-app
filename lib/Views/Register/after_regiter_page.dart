
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Login/login.dart';

class AfreRegisterPage extends StatelessWidget {
  const AfreRegisterPage({Key? key}) : super(key: key);

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
                'Congratulations !',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    'You are registered.',
                    style: TextStyle(),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Login()),
                                (route) => false);
                      },
                      child: Text(
                        'login now',
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
// Future<bool> onexit(context) async {
//   return await showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5.0))),
//         child: Container(
//           margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
//           height: 100,
//           child: Column(
//             children: <Widget>[
//               const Text("Are you sure you want to exit?"),
//               Container(
//                 margin: const EdgeInsets.only(top: 22),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     InkWell(
//                       onTap: () {
//                        Navigator.pop(context);
//                       },
//                       child: Container(
//                         width: 100,
//                         height: 40,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 6),
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.blue.withOpacity(0.1),
//                                 offset: const Offset(0.0, 1.0),
//                                 blurRadius: 1.0,
//                                 spreadRadius: 0.0)
//                           ],
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: const Text(
//                           "No",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         SystemChannels.platform
//                             .invokeMethod('SystemNavigator.pop');
//                       },
//                       child: Container(
//                         width: 100,
//                         height: 40,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 6),
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.blue.withOpacity(0.1),
//                                 offset: const Offset(0.0, 1.0),
//                                 blurRadius: 1.0,
//                                 spreadRadius: 0.0)
//                           ],
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: const Text("Yes",
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}
