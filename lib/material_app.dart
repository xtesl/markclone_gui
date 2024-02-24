import 'package:flutter/material.dart';
import 'package:markclone/screens/auth_screens/sign_up_screen.dart';
import 'package:markclone/screens/auth_screens/verification_screen.dart';
import 'package:markclone/screens/home/Acount/profile_info.dart';
import 'package:markclone/screens/home/cart.dart';
import 'package:markclone/screens/home/index.dart';
import 'package:markclone/screens/home/search_screen.dart';
import 'package:markclone/screens/start_up_screens/intro_screen.dart';
import 'package:markclone/special_ui_elements/settings_switch_button.dart';
import 'package:provider/provider.dart';

class MarkClone extends StatelessWidget {
  const MarkClone({super.key});

//preload settings and functionalities before starting app
  Future<void> _peload(
      locationSwitchButtonDataModel,
      emailNotificationSwitchButtonDataModel,
      pushNotificationSwitchButtonDataModel,
      profileImageModel) async {
    //asynchronously load initial settings values
    await locationSwitchButtonDataModel.loadSwitchValue();
    await emailNotificationSwitchButtonDataModel.loadSwitchValue();
    await pushNotificationSwitchButtonDataModel.loadSwitchValue();
    await profileImageModel.loadProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    var location = LocationSwitchButtonDataModel();
    var pushNotification = PushNotificationSwitchButtonDataModel();
    var email = EmailNotificationSwitchButtonDataModel();
    var profileImage = ProfileImageModel();
    return FutureBuilder(
        future: _peload(location, email, pushNotification, profileImage),
        builder: (context, snapshot) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<LocationSwitchButtonDataModel>(
                    create: (context) => location),
                ChangeNotifierProvider<PushNotificationSwitchButtonDataModel>(
                  create: (context) => pushNotification,
                ),
                ChangeNotifierProvider<EmailNotificationSwitchButtonDataModel>(
                  create: (context) => email,
                ),
                ChangeNotifierProvider<ProfileImageModel>(
                    create: (context) => profileImage)
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: const IntroScreen(),
                routes: {
                  '/home': (context) => const Index(),
                  "/verificationScreen": (context) => const VerificationPage(),
                  '/signup': (context) => const SignupScreen(),
                  '/search': (context) => const SearchScreen(),
                  '/cart': (context) => const Cart()
                },
              ));
        });
  }
}
