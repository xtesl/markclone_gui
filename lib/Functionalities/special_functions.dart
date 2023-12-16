import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setStartedStatus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool('signed_up', true);
}

Future<bool?> getStartedStatus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool('signed_up');
}

Future<void> seekLocation() async {
  //Check if platform is alllowed to use location
  PermissionStatus locationPermissionStatus = await Permission.location.status;
  if (locationPermissionStatus.isDenied) {
    await Permission.location
        .request(); //Request for the location setting of the device
  } else if (locationPermissionStatus.isGranted) {
    //If permission is granted
  } else if (locationPermissionStatus.isPermanentlyDenied) {
    //is Permission is permanently denied
  }
}

void moveToPage(Widget page, context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

Future<void> sendCode() async {
  final uri = Uri.parse('http://192.168.54.144:5000'); //local host
  final response = await http.get(uri); //Make api call and grab response

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data[0]['name']);
    print(data[0]['email']);
    print(data[0]['id']);
  } else {
    print('error: ${response.statusCode}');
  }
}

Future<void> formData() async {
  final uri = Uri.parse('http://192.168.54.144:5000');
  final body = {'name': 'Justice', 'email': 'j34@gmail.com'};
  final response = await http.post(uri, body: jsonEncode(body));

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('failed with a stutus code of ${response.statusCode}');
  }
}
