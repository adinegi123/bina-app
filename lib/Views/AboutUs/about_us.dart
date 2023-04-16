import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },child: Icon(Icons.arrow_back_ios_sharp)),
        backgroundColor: Color(0xFF304803),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Image.asset('assets/images/bina_logo.png'),
            ),
          ),
          Text('Bina'.tr(),style: TextStyle(fontSize: 12),),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Center(child: Text('AboutUsDescription'.tr(),style: TextStyle(fontSize: 12,color: Colors.grey),))),
        ],
      ),
    );
  }
}
