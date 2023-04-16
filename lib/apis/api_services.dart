import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../Views/Categories/Model/category_model.dart';
import '../Views/Jobs/Model/jobs_model.dart';
import '../Widgets/snackbar.dart';
import '../constants/constants.dart';

class ApiService {
  bool isLoading = true;

  Future<dynamic> postAfterAuthMultiPart(Map parameter, File _image, url,
      BuildContext context, var filename) async {
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
            applyForJobUserModel.fromJson(jsonDecode(response.body));
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

  getBanners() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.bannersEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<CategoryModel?> getCategory() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.categoryEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var res = categoryModelFromJson(response.body);
        return res;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> register(FormData formData) async {
    try {
      var dio = Dio();
      Response<String> response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.registerEndPoint,
          data: formData);
      if (response.statusCode == 200) {
        return response.data.toString();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> login(FormData formData) async {
    try {
      var dio = Dio();
      Response<String> response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.loginEndPoint,
          data: formData);
      if (response.statusCode == 200) {
        return response.data.toString();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> get_sub_category(FormData formData) async {
    try {
      var dio = Dio();
      Response<String> response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.subCategoryEndPoint,
          data: formData);
      if (response.statusCode == 200) {
        return response.data.toString();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
