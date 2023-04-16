import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        backgroundColor: Color(0xFF304803),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Image.asset('assets/images/bina_logo.png'),
            ),
          ),
          Text(
            'Bina'.tr(),
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 50,
          ),
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          //     child: Center(child: Text('AboutUsDescription'.tr(),style: TextStyle(fontSize: 12,color: Colors.grey),))),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("AddressContactUs".tr(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.black12,
                //   endIndent: 30,
                //   indent: 30,
                // ),
                SizedBox(
                  height: 6,
                ),

                Text("AddressDescription".tr(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("MailContactUs".tr(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.black12,
                //   endIndent: 30,
                //   indent: 30,
                // ),
                Text('help@xclicks.ae',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 40,
                ),

                // Divider(
                //   thickness: 1,
                //   color: Colors.black12,
                //   endIndent: 30,
                //   indent: 30,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        Icons.call,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("WhatsappBContactUs".tr(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text('+971585651971',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
