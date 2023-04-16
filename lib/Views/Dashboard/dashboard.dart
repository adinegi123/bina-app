import 'dart:convert';


import 'package:bina_github/Views/ContactUsPage/contact_us.dart';
import 'package:bina_github/Views/Dashboard/Model/banner_model_new.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../AboutUs/about_us.dart';
import '../Categories/categories_section.dart';
import '../Login/login.dart';
import '../Profile/profile_page.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Dashboard',
//     home: Dashboard(),
//   ));
// }
//
// String _name="";
// String _email="";
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return _dashboardState();
//   }
// }
//
// class _dashboardState extends State<Dashboard> {
//
//
//   @override
//   void initState() {
//     getSharedPreferences();
//     super.initState();
//   }
//
//   getSharedPreferences () async
//   {
//     SharedPreferences myPref = await SharedPreferences.getInstance();
//     setState(() {
//       _name = myPref.getString("name")!;
//       _email = myPref.getString("email")!;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF91C121),
//         centerTitle: true,
//         // backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Bina",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // leading: GestureDetector(
//         //   onTap: () {/* Write listener code here */},
//         //   child: Icon(
//         //     Icons.menu, // add custom icons also
//         //   ),
//         // ),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Icon(
//                   Icons.search,
//                   size: 26.0,
//                 ),
//               )),
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Icon(Icons.more_vert),
//               )),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//
//               decoration: BoxDecoration(
//                 color: Color(0xFF304803),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children:  [
//                   Icon(Icons.account_circle,
//                       size: 70,
//                       color: Colors.white
//                   ),
//                   SizedBox(height: 5),
//                 Text(_name,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20),
//                   ),
//                   SizedBox(height: 5),
//                   Text(_email,
//                     style: TextStyle(
//                         color: Colors.greenAccent,
//                         fontSize: 14),
//                   ),
//                 ],
//               ),
//               //
//               // child:Text('$_name',
//               //   style: TextStyle(
//               //       color: Colors.white,
//               //       fontWeight: FontWeight.bold,
//               //       fontSize: 30),
//               // ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.home,
//               ),
//               title: const Text('Add Post'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.call,
//               ),
//               title: const Text('Contact Us'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.verified_user_sharp),
//               title: const Text('About Us'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: ()  {
//                 logout(context);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             CarouselSlider(
//               items: [
//                 //1st Image of Slider
//                 //1st Image of Slider
//                 Container(
//                   margin: EdgeInsets.all(6.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           "https://c8.alamy.com/comp/2BHNK89/web-banner-template-for-advertisement-with-space-for-adding-your-picture-2BHNK89.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 //1st Image of Slider
//                 Container(
//                   margin: EdgeInsets.all(6.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           "https://c8.alamy.com/comp/2BHNK89/web-banner-template-for-advertisement-with-space-for-adding-your-picture-2BHNK89.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 //1st Image of Slider
//                 Container(
//                   margin: EdgeInsets.all(6.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           "https://c8.alamy.com/comp/2BHNK89/web-banner-template-for-advertisement-with-space-for-adding-your-picture-2BHNK89.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 //1st Image of Slider
//                 Container(
//                   margin: EdgeInsets.all(6.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           "https://c8.alamy.com/comp/2BHNK89/web-banner-template-for-advertisement-with-space-for-adding-your-picture-2BHNK89.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 //1st Image of Slider
//                 Container(
//                   margin: EdgeInsets.all(6.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           "https://c8.alamy.com/comp/2BHNK89/web-banner-template-for-advertisement-with-space-for-adding-your-picture-2BHNK89.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//
//               //Slider Container properties
//               options: CarouselOptions(
//                 height: 180.0,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 viewportFraction: 0.8,
//               ),
//             ),
//             CategoriesSection(),
//             BinaShopSection(),
//             PostSection(),
//             PostSection(),
//             PostSection(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   logout(BuildContext context) {
//
//     // set up the button
//     Widget okButton = TextButton(
//       child: Text("Logout"),
//       onPressed: () async {
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         await pref.clear();
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => Login(),
//           ),
//               (route) => false,
//         );
//       },
//     );
//     Widget noButton = TextButton(
//       child: Text("cancel"),
//       onPressed: () {
//         Navigator.of(context).pop(false);
//       },
//     );
//
//     // show the dialog
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return BackdropFilter(
//             child: AlertDialog(
//               title: Text("Alert !"),
//               content: Text("are you sure you want to logout ?"),
//               actions: [
//                 okButton,
//                 noButton,
//               ],
//             ),
//             filter: ui.ImageFilter.blur(sigmaX: 4.0,sigmaY: 4.0));
//       },
//     );
//   }
// }
//
// class CategoriesSection extends StatefulWidget {
//   const CategoriesSection({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _categorieState();
//   }
// }
//
// class _categorieState extends State<CategoriesSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               buildCommonServiceCard(),
//               buildCommonServiceCard(),
//               buildCommonServiceCard(),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               buildCommonServiceCard(),
//               buildCommonServiceCard(),
//               buildCommonServiceCard(),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               buildCommonServiceCard(),
//               buildCommonServiceCard(),
//               buildCommonServiceCard(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildCommonServiceCard() {
//     return Flexible(
//               child: Container(
//                 margin: EdgeInsets.all(10.0),
//                 padding: EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFffffff),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Color(0xFF3D3D3D), //New
//                         blurRadius: 5.0,
//                         offset: Offset(0, 5))
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                   Image.asset('assets/images/contractor.png',height: 70,width: 70,),
//                     Text("Job",style: TextStyle(fontSize: 12,color: Colors.black),),
//                   ],
//                 ),
//               ),
//               flex: 1,
//             );
//   }
// }
//
// class BinaShopSection extends StatefulWidget {
//   const BinaShopSection({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _binaEshopState();
//   }
// }
//
// class _binaEshopState extends State<BinaShopSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: Color(0xFF91C121),
//       margin: EdgeInsets.all(20),
//       padding: EdgeInsets.all(40),
//       child: Text(
//         "Bina eShop",
//         style: TextStyle(fontSize: 25, color: Colors.white),
//       ),
//     );
//   }
// }
//
// class PostSection extends StatefulWidget {
//   const PostSection({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _postSectionState();
//   }
// }
//
// class _postSectionState extends State<PostSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10.0),
//       padding: EdgeInsets.all(5.0),
//       decoration: BoxDecoration(
//         color: Color(0xFFffffff),
//         borderRadius: BorderRadius.circular(5),
//         boxShadow: [
//           BoxShadow(
//               color: Color(0xFF3D3D3D), //New
//               blurRadius: 25.0,
//               offset: Offset(0, 5))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 200.0,
//                 width: 150.0,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(200),
//                 ),
//                 child: Center(
//                   child: Image.asset('assets/images/post.jpg'),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Hiring",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22),
//                     ),
//                     Text(
//                       "Android developer, php developer, \n5 yrs experience, agile spectrum\nlorem ipsum",
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Divider(color: Colors.black),
//           Row(),
//           Divider(color: Colors.black),
//         ],
//       ),
//     );
//   }
// }
// Widget servicesContainer(){
//   return Card(
//     child: Column(
//       children: [
//
//       ],
//     ),
//   );
// }
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Dashboard',
//     home: Dashboard(),
//   ));
// }

String _name = "";
String _email = "";
String _contact = "";
int? count = 0;
bool isLoading = true;

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required var userData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _dashboardState();
  }
}

class _dashboardState extends State<Dashboard> {
  var caroselSliderList = [];
  var stateList;
  String messageNotification = '';
  String messageTitle = '';
  String userId = '';

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
    getSliderData();

  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    var deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      _name = myPref.getString("name")!;
      _email = myPref.getString("email")!;
      userId = myPref.getString("user_id")!;

      // _contact=myPref.getString('mobile')!;
    });
    print(
        "inside dashboard-------->>>>>>>>>>>>>user - Id==========>>>>>>>>>>>>>>$userId");
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF304803),
        centerTitle: true,
        // backgroundColor: Colors.transparen                                                                                                                                                         t,
        elevation: 0.0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Image.asset('assets/images/bina_logo.png'),
          ),
        ),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 8.0, right: 10, bottom: 8),
            child: InkWell(
                onTap: () {


                },
                child: Icon(
                  Icons.notifications,
                  size: 25,
                )),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF304803),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Image.asset('assets/images/bina_logo.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 15),
                      child: Text(
                        'bina'.tr().toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('home'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Divider(
              indent: 5.0,
              endIndent: 5.0,
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title: Text('profile'.tr()),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfilePage()));
                },
              ),
            ),
            // Divider(
            //   indent: 5.0,
            //   endIndent: 5.0,
            // ),
            // SizedBox(
            //   height: 45,
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.people_alt,
            //     ),
            //     title: const Text('Company Profile'),
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (_) => ProfilePage()));
            //     },
            //   ),
            // ),
            Divider(
              indent: 5.0,
              endIndent: 5.0,
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(
                  Icons.call,
                ),
                title: Text('ContactUs'.tr()),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ContactUsPage()));
                },
              ),
            ),
            Divider(
              indent: 5.0,
              endIndent: 5.0,
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(
                  Icons.language,
                ),
                title: Text('english'.tr()),
                onTap: () async {
                  context.locale = Locale('en', 'US');
                },
              ),
            ),
            Divider(
              indent: 5.0,
              endIndent: 5.0,
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(
                  Icons.language,
                ),
                title: Text('arabic'.tr()),
                onTap: () async {
                  context.locale = Locale('ar', 'AE');
                },
              ),
            ),
            Divider(
              indent: 5.0,
              endIndent: 5.0,
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(Icons.verified_user_sharp),
                title: Text('AboutUs'.tr()),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AboutUsPage()));
                },
              ),
            ),
            Divider(
              indent: 5.0,
              endIndent: 5.0,
            ),
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'.tr()),
                onTap: () {
                  logout(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            isLoading
                ? CircularProgressIndicator()
                : CarouselSlider.builder(
              itemCount: caroselSliderList.length,
              options: CarouselOptions(
                aspectRatio: 12 / 9,
                initialPage: 0,
                height: 220,
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (BuildContext context, int itemIndex,
                  int pageViewIndex) {
                int index = itemIndex;
                return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // image: DecorationImage(
                                //   image: ,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: caroselSliderList.isEmpty
                                  ? Text('')
                                  : Image.network(ApiConstants.imageUrl +
                                  caroselSliderList[index]
                                      .bannerImage
                                      .toString())),
                        ),
                      ],
                    ));
              },
            ),
            CategoriesSection(),
            // BinaShopSection(),
            // ListView.builder(
            //   itemBuilder: (context, index) {
            //     // print(ApiConstants.imageUrl+caroselSliderList[index].bannerImage.toString());
            //     return PostSection();
            //   },
            //   itemCount: 3,
            //   shrinkWrap: true,
            //   physics: BouncingScrollPhysics(),
            // ),
          ],
        ),
      ),
    );
  }

  Container reusableContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Text('6/10/2022'),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.calendar_month,
          )
        ],
      ),
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
        return BackdropFilter(
            child: AlertDialog(
              title: Text("Alert !"),
              content: Text("are you sure you want to logout ?"),
              actions: [
                okButton,
                noButton,
              ],
            ),
            filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0));
      },
    );
  }

  //Api methods
//   Future getSliderData() async {
//     await ApiService().getBanners().then((value) {
//       if (value==200) {
// print(value);
//       }
//       // bool isLoading = true;
//       // if (isLoading = true) {}
//     });
//   }

  Future getSliderData() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.bannersEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bannerResponse = bannerModelNew.fromJson(jsonDecode(response.body));
      if (bannerResponse.status == 200) {
        setState(() {
          isLoading = false;
        });
        print(bannerResponse.data![0].bannerName);
        print(caroselSliderList = bannerResponse.data!);
        print(caroselSliderList![0].bannerName);
        print(caroselSliderList!.length);
        print(ApiConstants.imageUrl +
            caroselSliderList![0].bannerImage.toString());
      }
    } else {
      print('error');
    }
  }
}
