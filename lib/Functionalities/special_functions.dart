import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/auth_screens/verification_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:markclone/constants/endpoints.dart' as urls;

Map<String, double> getScreenDimensions(context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return {'height': screenHeight, 'width': screenWidth};
}

Future<void> setData(String as, String? data) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(as, data!);
}

Future<String?> getData(String as) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(as);
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

void showMessage(message, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: CustomColors.primaryColor, // Eye-catching color
    content: Row(
      children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),

    action: SnackBarAction(
      label: 'Got it!',
      textColor: Colors.white,
      onPressed: () {}, // Optional action
    ),
  ));
}

Future<dynamic> sendFormData(data, url) async {
  try {
    final uri = Uri.parse(url);
    final body = jsonEncode(data); // form data
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      return response; //Parse response from server
    } else {
      return response;
    }
  } on SocketException {
    print('No internet connection');
  }
}

Future<Uint8List?> imageToBytes(XFile? image) async {
  if (image == null) return null;
  File imageFile = File(image.path);
  Uint8List imageBytes =
      await imageFile.readAsBytes(); // convert image file into byte array
  return imageBytes;
}

Future<dynamic> fetchProducts(String url) async {
  try {
    final uri = Uri.parse(url);
    final response = await http
        .get(uri); //make and receive http request from the MingleCart API
    return response;
  } catch (err) {
    rethrow;
  }
}

///validators for the forms i.e email and password
bool validateEmail(String email) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

bool validatePassword(String password) {
  final passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{6,}$');
  return passwordRegex.hasMatch(password);
}

//Authenticate and login users
Future<dynamic> login(data, url, context) async {
  await Future.delayed(const Duration(seconds: 2));
  var response = await sendFormData(data, url).then((response) {
    //server ok with the login
    return response;
  });

  return response;
}

void showLoading(context) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: CustomColors.primaryColor,
        ),
      );
    },
  );

  await Future.delayed(const Duration(seconds: 1));
}

//Register users
Future<dynamic> register(data, url, context) async {
  await Future.delayed(const Duration(seconds: 2));
  var response = await sendFormData(data, url).then((response) {
    //pass user's id to verification page for api call
    VerificationPage.userId = json.decode(response.body)['id'];
    //pass otp for verification
    VerificationPage.otp = json.decode(response.body)['otp'];
    return response;
  });

  return response;
}

//verify user's otp
Future<dynamic> verifyOTP(otp, context) async {
  //backend operations
  String url = '${urls.verifyOTP}/${VerificationPage.userId}';
  var response = await sendFormData(otp, url).then((response) {
    return response;
  });

  return response;
}

Future<bool> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return status.isGranted;
}

Future<String?> saveImage(XFile image) async {
  if (!await requestStoragePermission()) return null;

  Directory? directory = await getExternalStorageDirectory();
  if (directory == null) return null;

  String newPath = path.join(directory.path, 'MingleCart');
  directory = Directory(newPath);

  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }

  if (await directory.exists()) {
    File savedImage = File(path.join(newPath, path.basename(image.path)));
    await savedImage.writeAsBytes(await image.readAsBytes());
    return savedImage.path;
  }

  return null;
}

Future<void> checkFirstRun() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isFirstRun = sharedPreferences.getBool('isFirstRun') ?? true;
  if (isFirstRun) {
    sharedPreferences.clear();
    sharedPreferences.setBool('isFirstRun', false);
  }
}
