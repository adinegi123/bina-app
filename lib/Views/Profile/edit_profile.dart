import 'package:bina_github/Views/Profile/Class/edit_profile_class.dart';
import 'package:bina_github/Views/Profile/edit_profile_page_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/profile_widget.dart';
import '../../constants/constants.dart';
import '../Other/user_preferences.dart';

class EditProfilepage extends StatefulWidget {
  const EditProfilepage({Key? key}) : super(key: key);

  @override
  State<EditProfilepage> createState() => _EditProfilepageState();
}

class _EditProfilepageState extends State<EditProfilepage> {
  String _name = "";
  String _email = "";
  String _contactNo = "";
  String _userType = "";
  String _about = "";
  String user_image = "";
  String membershipId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUserProfile;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
          ),
          backgroundColor: const Color(0xFF304803),
          centerTitle: true,
          title: const Text('Edit Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            ProfileWidget(
              imagePath: ApiConstants.imageUrl + user_image,
              onClicked: () async {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditprofilePageTwo()))
                    .then((value) {
                  getSharedPreferences();
                });
                setState(() {
                  isEdit:
                  true;
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            buildName(_name),
            const SizedBox(
              height: 40,
            ),
            //buildUpgradeButton(),

            Row(
              children: [
                Expanded(child: buildButton(context, _email, 'email'.tr())),
                const SizedBox(
                  height: 22,
                  child: VerticalDivider(
                    width: 3,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: buildButton(context, _contactNo, 'contact'.tr())),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: buildButton(
                        context, membershipId, 'membershipId'.tr())),
                // const SizedBox(
                //   height: 22,
                //   child: VerticalDivider(
                //     width: 3,
                //     color: Colors.black,
                //   ),
                // ),
                Expanded(
                    child: buildButton(
                        context,
                        _userType == 'company'
                            ? 'company'.tr()
                            : 'individual'.tr(),
                        'status'.tr())),
              ],
            ),
            const SizedBox(height: 58),
            buildAbout(user),
          ],
        ));
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      _name = myPref.getString("name") ?? '';
      _email = myPref.getString("email") ?? '';
      _contactNo = myPref.getString("mobile") ?? '';
      _about = myPref.getString("short_bio") ?? '';
      user_image = myPref.getString("user_image") ?? '';
      membershipId = myPref.getString("membershipId") ?? '';
      _userType = myPref.getString("type") ?? '';
    });

    print("after setting user image in preference---------->$user_image");
    print("after setting membershipId in preference---------->$membershipId");
    print("after setting user type in preference---------->$_userType");
  }

  Widget buildName(name) {
    return Center(
      child: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }

  // Widget buildUpgradeButton() {
  //   return ButtonWidget(onClicked: () {}, text: 'Upgrade');
  // }

  Widget buildButton(BuildContext context, String text, String value) {
    return MaterialButton(
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildAbout(Profile user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'about'.tr(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _about,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      );
}
