import 'dart:io';
import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageModel with ChangeNotifier {
  File? _image;
  String imageKey = 'profilePhotoPath';

  File? get getProfileImmage => _image;

  Future<void> loadProfileImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //image path from sharedprefs
    String? imagePath = sharedPreferences.getString(imageKey);
    //create image file using image path
    _image = File(imagePath!);
    notifyListeners();
  }

  Future<void> setPrfileImage(XFile? image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //update image if necessary
    if (image != null) {
      sharedPreferences.setString(imageKey, image.path);
      //load the new image
      _image = File(sharedPreferences.getString(imageKey)!);
      notifyListeners(); //update consumer widgets
    }
  }
}

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  //pick image from gallery
  File? image;

  Future<Map<String, int>> getImageResolution(XFile file) async {
    final bytes = await file.readAsBytes(); // read image file as bytes
    //decode image file using image package
    final img.Image? image = img.decodeImage(bytes);
    if (image != null) {
      int height = image.height;
      int width = image.width;
      Map<String, int> dimensions = {'height': height, 'width': width};
      return dimensions;
    }

    return {};
  }

  Future<String> checkImageSize(File image) async {
    int fileSizeInBytes = await image.length(); //image size in bytes
    //image size in MB
    return (fileSizeInBytes / (1024 * 1024)).toStringAsFixed(2);
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: CustomColors.primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> isImageSizeValid(File image) async {
    double maxImageSize = 2.00; //in MB
    double? imageSize = double.tryParse(
        await checkImageSize(File(image.path))); //picked image size
    //Reject larger images i.e size > 2.00MB

    return imageSize! <= maxImageSize ? true : false;
  }

  Future<File?> _pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery); //get image from gallery

      if (image != null) {
        //image size validity check
        if (!await isImageSizeValid(File(image.path))) {
          _showAlert('Image too large', 'Please choose an image less that 2MB');
        }
        return File(image.path);
      }
    } catch (err) {
      _showAlert('Error', 'Failed to pick image');
    }

    return null;
  }

  Future _takePhoto() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera); //get image from camera
    if (image != null) {
      await setData('profilePhotoPath', image.path);
      setState(() {
        this.image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(230, 230, 230, 1.0),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenDimensions['width']! * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Material(
                elevation: 6.0,
                shadowColor: Colors.white,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenDimensions['width']! * 0.55),
                        child: Text(
                          'Profile Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenDimensions['width']! * 0.04),
                        ),
                      ),
                      Consumer<ProfileImageModel>(
                        builder: (context, model, child) => Center(
                          child: model.getProfileImmage != null
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          size: screenDimensions[
                                                                  'width']! *
                                                              0.07,
                                                        ))
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: screenDimensions[
                                                              'height']! *
                                                          0.15),
                                                  child: SizedBox(
                                                    child: Image(
                                                      image: FileImage(
                                                        image!,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: getScreenDimensions(
                                              context)['width']! *
                                          0.2,
                                      backgroundImage:
                                          FileImage(model.getProfileImmage!)),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: const AssetImage(
                                    'assets/images/profile_default_1.png',
                                  ),
                                  radius:
                                      getScreenDimensions(context)['width']! *
                                          0.2),
                        ),
                      ),
                      Consumer<ProfileImageModel>(
                        builder: (context, model, child) => Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.primaryColor),
                            child: TextButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return Container(
                                        constraints: BoxConstraints(
                                            maxHeight: getScreenDimensions(
                                                    context)['height']! *
                                                0.2,
                                            minWidth: getScreenDimensions(
                                                context)['width']!),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await _takePhoto(); //take with phone's camera
                                                    },
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      size: getScreenDimensions(
                                                                  context)[
                                                              'width']! *
                                                          0.2,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                  height: getScreenDimensions(
                                                          context)['height']! *
                                                      0.05),
                                              Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      // Add image from gallery

                                                      File? image =
                                                          await _pickImage();

                                                      model.setPrfileImage(
                                                          XFile(image!.path));
                                                    },
                                                    icon: Icon(Icons.image,
                                                        size:
                                                            getScreenDimensions(
                                                                        context)[
                                                                    'width']! *
                                                                0.2),
                                                  ),
                                                  const Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: const Text(
                                'Change Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // DatePickerDialog(
                      //     firstDate: DateTime(2029), lastDate: DateTime(2004))
                      const Divider(),
                      ListTile(
                        title: const Text('Username'),
                        subtitle: const Text(
                          'Set a public name',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        trailing: V3CustomButton(
                          onpressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenDimensions['width']! * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Material(
                elevation: 6.0,
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenDimensions['width']! * 0.54),
                        child: Text(
                          'Account Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenDimensions['width']! * 0.04),
                        ),
                      ),
                      ListTile(
                        title: const Text('Security and Login'),
                        subtitle: const Text(
                          'Change your password and login preferences',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        trailing: V3CustomButton(onpressed: () {}),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Email'),
                        subtitle: const Text(
                          'Change your email address',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        trailing: V3CustomButton(onpressed: () {}),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Phone'),
                        subtitle: const Text(
                          'Change your phone number',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        trailing: V3CustomButton(onpressed: () {}),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Account Verification'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
