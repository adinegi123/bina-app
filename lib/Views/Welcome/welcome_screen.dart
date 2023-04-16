
import 'package:flutter/material.dart';

import '../../apis/api_services.dart';
import '../../constants/color.dart';
import '../Login/login.dart';
import 'Model/banner_model.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Welcome Screen',
    home: Welcome(),
  ));
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  double currentPage = 0.0;
  final _pageViewController = PageController();
  BannerModel? _bannerModel = null;
  var count = 0;

  var isLoaded = false;

  //added
  var _bannerList;

  @override
  void initState() {
    _getBanners();
    super.initState();
  }

  void _getBanners() async {
    var res = await ApiService().getBanners();
    print('******************************************');
    print(res);
    print(res!['data'][0]);
    if (res != null) {
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
        count = res!['data'].length;
        _bannerList = res!['data'];
        isLoaded = true;
      }));
    } else {
      print('banner is null');
      setState(() {
        isLoaded = true;
      });
    }

    //
  }

  List<Widget> indicator() => List<Widget>.generate(
      count,
          (index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
            color: currentPage.round() == index
                ? const Color(0xFF304803)
                : const Color(0XFF256075).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.0)),
      ));
  List images = [
    'assets/images/firstsplash.png',
    'assets/images/secondsplash.png',
    'assets/images/thirdsplash.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bg.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        painter: CurvePainter(),
        child: Stack(
          children: [
            FutureBuilder(
              future: ApiService().getBanners(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Visibility(
                    visible: isLoaded,
                    replacement: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF91C121),
                      ),
                    ),
                    child: PageView.builder(
                      controller: _pageViewController,
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        _pageViewController.addListener(() {
                          setState(() {
                            currentPage = _pageViewController.page!;
                          });
                        });
                        return Container(
                          padding: const EdgeInsets.only(
                              top: 54, left: 20, right: 20),
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Image.asset(
                                  // ApiConstants.imageUrl +
                                  //     _bannerList[index]['banner_image'],
                                  images[index].toString(),
                                  // snapshot.data![index],
                                  //_bannerModel!.result[index].bannerImage,
                                  fit: BoxFit.fitWidth,
                                  width: 300.0,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30, top: 150),
                                  child: Column(
                                    children: <Widget>[
                                      Text(_bannerList[index]['banner_name'],
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0XFF3F3D56),
                                              height: 2.0)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40.0),
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                )),
            // _getStartedBtn()
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF304803),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )),
                      )),
                ))
          ],
        ),
      ),
    );
  }

  Widget _getStartedBtn() => Align(
    alignment: Alignment.bottomCenter,
    child: ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)))),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
      child: const Text('Get  Started', style: TextStyle(fontSize: 25)),
    ),
  );
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = ColorConst.buttonColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.5, -size.height / 2,
        size.width / 0.05, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
