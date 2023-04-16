import 'dart:convert';
import 'dart:io';

import 'package:bina_github/Views/Dashboard/Model/get_rating_model.dart';
import 'package:bina_github/Views/DetailsPage/photo_details.dart';
import 'package:bina_github/Widgets/text_form_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../Widgets/snackbar.dart';
import '../../constants/constants.dart';
import '../../constants/images.dart';
import '../Dashboard/Model/save_rating_model.dart';
import 'commented_photo_details.dart';



class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int index;
  List<Map<String, String>> listPosts = [
    {
      'image': 'assets/images/post-1.jpg',
    },
    {
      'image': 'assets/images/post-2.jpg',
    },
    {
      'image': 'assets/images/post-3.jpg',
    },
    {
      'image': 'assets/images/post-4.jpg',
    },
    {
      'image': 'assets/images/post-5.jpg',
    },
    {
      'image': 'assets/images/post-6.jpg',
    },
    {
      'image': 'assets/images/post-4.jpg',
    },
    {
      'image': 'assets/images/post-8.jpg',
    },
    {
      'image': 'assets/images/post-9.jpg',
    },
  ];
  File? _file;
  File? fileToDisplay;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  var ratingstar = '';
  bool isLoading = true;
  var image_file;
  var fileToSend;
  var user_id = '';
  bool isratingLoading = true;
  var ratingList = [];
  TextEditingController reviewcontroller = TextEditingController();

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);

    setState(() {
      this._file = imageTemporary;
    });
  }

  Future pickFilePhoto(String? fileName) async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png']);

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        fileToDisplay = File(result!.files.first.path!);
        image_file = File(result!.files.single.path!);
        fileToSend = File(result!.files.single.path!);
        print('File-name:${_fileName}');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  uploadAssignmentApi(
      {String? user_id, String? rating, String? review, File? file}) async {
    Map param = {
      'user_id': user_id,
      'rating': rating,
      'review': review,
    };

    var response = await callUploadAssignmentApi(param, file!);
    print(user_id);
    print(rating.toString());
    print(review);

    isLoading = false;
    setState(() {});
  }

  Future<dynamic> callUploadAssignmentApi(
      Map parameter,
      File file,
      ) async {
    final response = await postAfterAuthMultiPartCompanyProfile(
        parameter,
        file,
        ApiConstants.baseUrl + ApiConstants.PostSaveUserRating,
        context,
        'rating_image');

    return response;
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    setState(() {
      user_id = myPref.getString("user_id") ?? "";
      print('user id after setting---------------------------->$user_id');
    });
    getRating();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        backgroundColor: Color(0xFF304803),
        title: Text('Company Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipOval(
                    child: Image.network(
                      height: 90,
                      width: 90,
                      "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Company Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(
                        thickness: 1,
                        color: Colors.black12,
                        endIndent: 30,
                        indent: 30,
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.orange,
                                size: 18,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text('Dubai,UAE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: VerticalDivider(
                                thickness: 1,
                                color: Colors.black12,
                                endIndent: 2,
                              ),
                            ),
                            Text('Since : 2008',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  Colors.grey.shade800,
                  Colors.white,
                ], radius: 0.85, focal: Alignment.center),
              ),
              child: GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .2),
                ),
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    child: Center(
                        child: Text(
                          'Average Rating',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        )),
                  ),
                  Container(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: 5.0,
                          minRating: 5,
                          direction: Axis.horizontal,
                          itemSize: 12,
                          ignoreGestures: true,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Text(
                          "(5)",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    child: Center(
                        child: Text(
                          'Membership ID',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        )),
                  ),
                  Container(
                    color: Colors.black,
                    child: Center(
                        child: Text(
                          '10000234',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 36,
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: Image.asset(
                              Images.pngWatsapp,
                              height: 30,
                              width: 30,
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            child: Icon(
                              Icons.call,
                              color: Colors.black,
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            child:
                            Icon(Icons.location_on, color: Colors.orange)))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introduction :',
                    style: TextStyle(fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Since Google\'s launch in 1997, its online domination has risen dramatically, becoming a necessary tool in our daily life. The word "google" was formally included in both the Merriam-Webster Collegiate Dictionary and the Oxford English Dictionary in 2006, demonstrating Google\'s dominance of the Internet',
                      style: TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Website :',
                    style: TextStyle(fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'compnay_name@companydomain.com',
                      style: TextStyle(fontSize: 11, color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                          ),
                        ),
                        Spacer(),
                        Divider(
                          height: 1,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Spacer(),
                        Icon(
                          Icons.grid_view,
                          size: 30,
                        ),
                        const Spacer(),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildGridView(),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text('Add Review',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black)),
                        Expanded(
                          child: Divider(
                            indent: 5,
                            endIndent: 10,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      hintText: 'Write your review',
                      maxLines: 3,
                      controller: reviewcontroller,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter review';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rate',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                          Center(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'How was your Experience',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 0.0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemSize: 17,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        ratingstar = rating.toString();
                                        print(rating);
                                        print(ratingstar);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add photo',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              String? _fileName;
                              pickFilePhoto(_fileName);
                            },
                            child: pickedFile != null
                                ? Center(
                              child: Image.file(
                                fileToDisplay!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            )
                                : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Stack(children: <Widget>[
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 70,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        // color: Color(0xFF304803).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black)),
                      child: TextButton(
                        child: Center(
                            child: Text('submit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            uploadAssignmentApi(
                                user_id: user_id.toString(),
                                rating: ratingstar.toString(),
                                review: reviewcontroller.text.toString(),
                                file: image_file);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isratingLoading
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Previous Reviews',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                    )
                        : Container(),
                    review_comment_tile()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        final post = listPosts[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        PhotoDetailPage(var1: index),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    }));
            setState(() {
              index = index;
              print(index);
            });
          },
          child: Hero(
            tag: 'btn1$index',
            child: Container(
              color: Colors.orangeAccent,
              child: Image.asset(
                Images.jpgPost,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      itemCount: listPosts.length,
    );
  }

  Widget profileButton(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 36,
      decoration: BoxDecoration(color: Colors.black12),
      child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )),
    );
  }

  Future<dynamic> postAfterAuthMultiPartCompanyProfile(Map parameter,
      File _image, url, BuildContext context, var filename) async {
    var responseJson;
    //  SharedPreferences box = await SharedPreferences.getInstance();
    // String token = box.getString(NetworkConstants.token) ?? '';
    try {
      final response = http.MultipartRequest("POST", Uri.parse(url));
      // response.headers['authorization'] = "Bearer " + token;
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }
      if (_image != null) {
        var stream = http.ByteStream(Stream.castFrom(_image.openRead()));
        var length = await _image.length();
        var multipartFile = http.MultipartFile(filename, stream, length,
            filename: _image.path.toString());
        response.files.add(multipartFile);
      }
      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          if (response.statusCode == 200) {
            var responseee =
            saveRatingModel.fromJson(jsonDecode(response.body));
            print('File Uploaded Successfully!');

            print(responseee.message);
            SnackBarService.showSnackBar(
                context, responseee.message.toString());
            Navigator.pop(context);

            return response.body;
          } else {
            print('File Uploaded Failed!');
            return "NetworkConstants.error";
          }
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
        SnackBarService.showSnackBar(context, e.toString());
      }

      return 'NetworkConstants.error';
      //  throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Widget review_comment_tile() {
    return isratingLoading
        ? CircularProgressIndicator()
        : ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ratingList!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  minLeadingWidth: 0,
                  horizontalTitleGap: 10,
                  leading: ratingList[index].userImage == ""
                      ? CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    radius: 20,
                    backgroundImage: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/2048px-Circle-icons-profile.svg.png')
                        .image,
                  )
                      : CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    radius: 20,
                    backgroundImage: Image.network(ApiConstants
                        .imageUrl +
                        ratingList[index].userImage.toString())
                        .image,
                  ),
                  title: Text(ratingList[index].name!.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                      )),
                  subtitle: RatingBar.builder(
                    initialRating: double.parse(ratingList[index].rating!),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemSize: 15,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding:
                    const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(ratingList[index].review.toString(),
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    // DateFormat("dd-MM-yyyy").format(
                    //     DateTime.fromMillisecondsSinceEpoch(int.parse(controller
                    //         .reviews![index]['created_at']
                    //         .toString()))),,
                    ratingList[index].entrydt.toString(),
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // InkWell(
                //   onTap: (){
                //     Navigator.push(
                //         context,
                //         PageRouteBuilder(
                //             pageBuilder: (context, animation,
                //                 secondaryAnimation) =>
                //                 CommentedPhotoDetailPage(var1: index,var2:ratingList[index].photos.toString()),
                //             transitionsBuilder: (context, animation,
                //                 secondaryAnimation, child) {
                //               return child;
                //             }));
                //   },
                //   child: Hero(
                //     tag: 'btn2$index',
                //     child: Container(
                //       height: 100,
                //       width: 100,
                //       margin: EdgeInsets.symmetric(horizontal: 10),
                //       child: Image.network(ApiConstants.imageUrl +
                //           ratingList[index].photos.toString()),
                //     ),
                //   ),
                // ),
                // //
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                CommentedPhotoDetailPage(
                                    var1: index,
                                    var2: ratingList[index]
                                        .photos
                                        .toString()),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return child;
                            }));
                  },
                  child: Hero(
                    tag: 'btn2$index',
                    child: Container(
                      height: 95,
                      width: 140,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                          "${ApiConstants.imageUrl}${ratingList[index].photos.toString()}",
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bina_logo.png',
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/bina_logo.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getRating() async {
    setState(() {
      isratingLoading = true;
    });

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getRatingEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        isratingLoading = false;
      });
      var modelresponse = getratingModel.fromJson(json.decode(response.body));
      if (modelresponse.status == true) {
        ratingList = modelresponse.data!;
        print(ratingList!);
      }
    } else {
      SnackBarService.showSnackBar(context, 'some error occurred');
    }
  }
}
