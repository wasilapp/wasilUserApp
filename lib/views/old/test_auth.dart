import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class Crud {
  File? imageFile;

  static postRequest(String url, Map data) async {

    try {
      var response = await post(Uri.parse(url), body: data, headers: {});
      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        print('**********');
        print(resData);
        return resData;
      } else {
        print('Status Code ${response.statusCode}');
      }
    } catch (ex) {
      print('Exception ${ex.toString()}');
    }
  }

  static getRequest(String url) async {
    try {
      var response = await get(Uri.parse(url), headers: {
        // 'Authorization': sharedPreferences.getString('token') ?? ''
      });
      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        print('**********');
        print(resData);
        return resData;
      } else {
        print('Status Code ${response.statusCode}');
      }
    } catch (ex) {
      print('Exception ${ex.toString()}');
    }
  }

  static uploadFile(String url, Map data, File file) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multiPartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error ${myRequest.statusCode}');
    }
  }

  void openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);
      imageFile = imageTemp;
    } else {}
  }

  void openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);

      imageFile = imageTemp;
    } else {}
  }
}
