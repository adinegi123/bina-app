import 'dart:convert';

import 'package:bina_github/Views/Register/Model/company_registration.dart';
import 'package:bina_github/Views/Register/Model/individual_register_model.dart';
import 'package:bina_github/Views/Register/after_regiter_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar.dart';
import '../../constants/color.dart';
import '../../constants/constants.dart';
import '../Categories/category.dart';
import '../StatePageCategory/state_page_category.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Register',
    home: Register(),
  ));
}

var registerType = false;
var user_type = 'user';
var location = "";
double lat = 0.0;
double long = 0.0;
var category_id = 0;
var category_name = "";
var sub_category_id = 0;
var sub_category_name = "";
var address = 0;
var register_id = "";
bool isLoaded = false;

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _registerState();
  }
}

class _registerState extends State<Register> {
  late bool isIndividual = true;
  late bool isCompany = false;

  @override
  void initState() {
    super.initState;

    if (Category.cat_sub_cat_id.isEmpty) {
      print(Category.cat_sub_cat_id.length);
    }
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
                height: 120.0,
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
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
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
                  children: [
                    const Text(
                      'Register as',
                      style: TextStyle(
                        color: Color(0xFF304803),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {
                          registerType = true;
                          print("Ind Container clicked");
                          setState(() {
                            user_type = 'user';
                            registerType = !registerType;
                            isIndividual = true;
                            isCompany = false;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF304803),
                          radius: 45,
                          child: isIndividual
                              ? Stack(
                                  children: [
                                    Column(
                                      children: [
                                        isIndividual
                                            ? const Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.white,
                                              ),
                                        const Text(
                                          'INDIVIDUAL',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: 20,),s
                                    Positioned(
                                        bottom: 0,
                                        top: 1,
                                        left: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: ColorConst.buttonColor,
                                          ),
                                        ))
                                  ],
                                )
                              : Column(
                                  children: [
                                    isIndividual
                                        ? const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                    const Text(
                                      'INDIVIDUAL',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      InkWell(
                        onTap: () {
                          registerType = false;
                          user_type = 'company';
                          print("Company Container clicked");
                          setState(() {
                            registerType = !registerType;
                            isIndividual = false;
                            isCompany = true;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF304803),
                          radius: 45,
                          child: isCompany
                              ? Stack(
                                  children: [
                                    Column(
                                      children: const [
                                        Icon(Icons.groups,
                                            size: 60, color: Colors.white),
                                        Text(
                                          'COMPANY',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                        bottom: 15,
                                        top: 4,
                                        left: 7,
                                        right: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: ColorConst.buttonColor,
                                          ),
                                        )),
                                  ],
                                )
                              : Column(
                                  children: const [
                                    Icon(Icons.groups,
                                        size: 60, color: Colors.white),
                                    Text(
                                      'COMPANY',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ]),
                    RegisterForm(),
                  ],
                ),
              ),
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
    paint.color = const Color(0xFF91C121);
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

class RegisterForm extends StatefulWidget {
  String? restorationId;

  RegisterForm({super.key});

  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterForm> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();
  String value = 'Select Categeory';
  String cityValue = "Select City";
  String? categoryId;
  String? subCategory = '';
  var Categoryvalue;
  var cityName;
  bool isChecked = false;
  bool checkboxValue = false;
  bool obscureText = true;
  bool visibility = false;
  int? selectedCategory;
  var userType = 0;
  var stateList;

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();

  // Initial Selected Value
  String dropdownvalue = '--Select--';
  String Statedropdownvalue = '--Select City--';
  String? mtoken = " ";

  // List of items in our dropdown menu
  var items = [
    '--Select--',
    'Male',
    'Female',
  ];

  // REGISTER API
  postDataIndividual(
      String usertype,
      String userEmail,
      String username,
      String password,
      String dateOfBirth,
      String gender,
      String deviceId,
      String termsCondition,
      String mobile,
      String city) async {
    var queryParameters = {
      'user_type': usertype,
      'user_email': userEmail,
      'user_name': username,
      'password': password,
      'date_of_birth': dateOfBirth,
      'user_gender': gender,
      'terms_condition': termsCondition,
      'device_id': deviceId,
      'mobile': mobile,
      'city': city
    };
    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpointUser)
            .replace(queryParameters: queryParameters);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      // success
      print(response);
      var registerResponse =
          individualregistrationModelClass.fromJson(json.decode(response.body));
      if (registerResponse.status == 1) {
        // user registered successfully
        //new user registered
        SnackBarService.showSnackBar(
            context, registerResponse.result.toString());
        print("Congratulations!New user registered!");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool("isRegistered", true);
        var userData = registerResponse;
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => Dashboard(
        //               userData: userData,
        //             )));
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AfreRegisterPage()));
      } else {
        //user already exists
        SnackBarService.showSnackBar(
            context, registerResponse.result.toString());
      }
    } else {
      // show error
      SnackBarService.showSnackBar(context, 'some error occured');
    }
    print("responseData--->${response.body}");
    print("finalUrl--->$url");
  }

  postDataCompany(
      String usertype,
      String userEmail,
      String username,
      String password,
      String contact,
      String categoryId,
      String subcategoryId,
      String location,
      String deviceId,
      String termsCondition,
      String city) async {
    var queryParameters = {
      'user_type': usertype,
      'user_email': userEmail,
      'user_name': username,
      'password': password,
      'contact': contact,
      'category_id': categoryId,
      'sub_category_id': subcategoryId,
      'location': location,
      'device_id': deviceId,
      'terms_condition': termsCondition,
      'city': city
    };
    // print(
    //     'terms and conditions --------------------->>>${termsCondition.toString()}');
    // print(
    //     "category Id------------------?????????????????????${categoryId.toString()}");
    // print(
    //     "sub category Id------------------?????????????????????${subcategoryId.toString()}");
    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpointCompany)
            .replace(queryParameters: queryParameters);

    var response = await http.post(url);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // success
      var registerResponse =
          companyregistrationModelClass.fromJson(json.decode(response.body));
      if (registerResponse.status == 1) {
        SnackBarService.showSnackBar(
            context, registerResponse.result.toString());
        print("Congratulations!New Company registered!");
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool("isRegistered", true);

        var userData = registerResponse;
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AfreRegisterPage()));
      } else {
        //user already exists
        SnackBarService.showSnackBar(
            context, registerResponse.result.toString());
      }
    }
    print("responseData--->${response.body}");
    // print("finalUrl--->$url");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _nameController,
              decoration: const InputDecoration(hintText: "Name"),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r"^[\p{L} ,.'-]*$",
                            caseSensitive: false, unicode: true, dotAll: true)
                        .hasMatch(value)) {
                  return 'Please enter a valid Name';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _emailController,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(hintText: "Email"),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(value)) {
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
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _passwordController,
              obscureText: obscureText,

              decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          visibility = !visibility;
                          obscureText = !obscureText;
                        });
                      },
                      child: visibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else if (value.length <= 5) {
                  return 'Please enter a strong password';
                }
                return null;
              },
            ),
          ),
          Visibility(
            visible: !registerType,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: TextFormField(
                autofocus: false,
                onTap: () {
                  _restorableDatePickerRouteFuture.present();
                },
                controller: _dobController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(hintText: "Date of birth"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print(user_type);
                    return 'Please select date of birth';
                  }
                  return null;
                },
              ),
            ),
          ),
          Visibility(
            visible: !registerType,
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String item) {
                  print(user_type);
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _contactNumberController,
              cursorColor: const Color.fromRGBO(0, 0, 0, 1),
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(hintText: "Contact"),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone number should not be empty';
                } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                    .hasMatch(value)) {
                  return 'Please enter valid mobile number';
                } else {
                  return null;
                }
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: registerType,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Visibility(
                visible: false,
                replacement: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: const Color(0xFFD3D3D3),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      final newValue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Category(
                              data: Categoryvalue,
                            ),
                          ));

                      setState(() {
                        value = newValue["value"];
                        categoryId = newValue["categoryId"].toString();
                        print('----' + newValue['subCategoryId'].toString());
                        if (newValue["subCategoryId"] != null) {
                          subCategory = newValue['subCategoryId'].toString();
                        } else {
                          subCategory = '';
                        }
                        print(categoryId = newValue["categoryId"]);
                        // this.categoryId=newValue(categoryId!);
                        // print(categoryIndex);
                      });
                    },
                    child: Text(value),
                  ),
                ),
                child: TextFormField(
                  cursorColor: Colors.black,

                  decoration: const InputDecoration(hintText: "Category"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select category';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => StatePageCategory(data: cityName)));
              setState(() {
                cityValue = result['name'];
              });
            },
            child: Visibility(
              visible: false,
              replacement: Container(
                margin: const EdgeInsets.only(left: 20.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: const Color(0xFFD3D3D3),
                  ),
                ),
                child: Text(cityValue),
              ),
              child: TextFormField(
                cursorColor: Colors.black,

                decoration: const InputDecoration(hintText: "Category"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select category';
                  }
                  return null;
                },
              ),
            ),
          ),
          Visibility(
            visible: registerType,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: TextFormField(
                cursorColor: Colors.black,
                controller: _locationController,

                decoration:
                    const InputDecoration(hintText: "Enter Full Location"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
            ),
          ),
          FormField(
            validator: (value) {
              if (value == false) {
                return 'you need to accept terms';
              }
              return null;
            },
            builder: (state) => Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, //Center Row contents horizontally,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: checkboxValue,
                          onChanged: (bool? value) {
                            if (checkboxValue == false) {
                              setState(() {
                                checkboxValue = true;
                                isChecked = true;
                              });
                            } else if (checkboxValue == true) {
                              setState(() {
                                checkboxValue = false;
                                isChecked = false;
                              });
                            }
                          }),
                      const Center(
                        child: FittedBox(
                          child: Text('I agree in the'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Terms & services'),
                      ),
                      const Center(
                        child: Text('and'),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 43),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF304803),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                onPressed: () async {
                  if (registerType) {
                    // postCompany();
                    if (_formKey.currentState!.validate() &&
                        checkboxValue == true) {
                      print("company");
                      print("user type in company registration$user_type");

                      postDataCompany(
                          user_type.toString(),
                          _emailController.text.toString(),
                          _nameController.text.toString(),
                          _passwordController.text.toString(),
                          _contactNumberController.text.toString(),
                          categoryId!,
                          subCategory.toString(),
                          _locationController.text.toString(),
                          mtoken.toString(),
                          isChecked.toString(),
                          cityValue.toString());
                      print(
                          "user type in after login company registration$user_type");
                    }
                  } else if (!registerType) {
                    if (_formKey.currentState!.validate() &&
                        checkboxValue == true) {
                      print("user type in company registration$user_type");
                      postDataIndividual(
                          user_type.toString(),
                          _emailController.text.toString(),
                          _nameController.text.toString(),
                          _passwordController.text.toString(),
                          _dobController.text.toString(),
                          dropdownvalue.toString(),
                          mtoken.toString(),
                          isChecked.toString(),
                          _contactNumberController.text.toString(),
                          cityValue.toString());
                      print("single");
                      print(
                          "user type in after login individual registration$user_type");
                    }
                  } else {
                    SnackBarService.showSnackBar(
                        context, 'terms and conditions are required');
                  }
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2005, 1));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1960, 1),
          lastDate: DateTime(2005, 12, 31),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        _dobController.text =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

// Future<String?> requestToRegister(
//     String name, String email, String password, String dob) async {
//   var formData = FormData.fromMap({
//     'name': name,
//     'email': email,
//     'password': password,
//     'dob': dob,
//     'sex': dropdownvalue,
//     'mobile': "",
//     'category_id': 0,
//     'category_name': "",
//     'sub_category_id': 0,
//     'sub_category_name': "name",
//     'address': "",
//     'lat': lat.toString(),
//     'lon': long.toString(),
//     'signup_as': (registerType) ? "company" : "individual",
//     'register_id': "",
//   });

//     String? response = (await ApiService().register(formData));
//
//     if (response != null || response!.isNotEmpty) {
//       Map<String, dynamic> registerData = json.decode(response);
//
//       if (registerData['status'] == 1) {
//         Map<String, dynamic> result = registerData['result'];
//         // RegisterModel registerModel = registerModelFromJson(response);
//
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setBool("isLoggedin", true);
//         prefs.setString("name", result['name']);
//         prefs.setString("email", result['email']);
//         prefs.setString("dob", result['dob']);
//         prefs.setString("contact", result['mobile']);
//         prefs.setString("about", result['contactNo']);
//         prefs.setString('short_bio', result['short_bio']);
//         prefs.setString("user_id", result['user_id']);
//         prefs.setString("location", result['location']);
//         var userData = registerData;
//
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => Dashboard(
//               userData: userData,
//             ),
//           ),
//           (route) => false,
//         );
//       } else {
//         _nameController.text = "";
//         _emailController.text = "";
//         _passwordController.text = "";
//         _dobController.text = "";
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(registerData['result']),
//         ));
//       }
//     }
//     return null;
//   }
// }
}
