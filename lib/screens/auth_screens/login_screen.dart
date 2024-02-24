import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/special_ui_elements/animation_visuals.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/custom_forms.dart';
import 'package:markclone/constants/endpoints.dart' as endpoints;

enum SigninOptions { phone, email }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static bool showScreen = true;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SigninOptions option = SigninOptions.phone;
  @override
  void dispose() {
    super.dispose();
    LoginScreen.showScreen = true;
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen.showScreen
        ? Visibility(
            visible: LoginScreen.showScreen,
            child: PopScope(
              canPop: false,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SafeArea(
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      FocusScope.of(context)
                                          .unfocus(); // Remove any focus from widget
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: CustomColors.primaryColor,
                                    ))
                              ],
                            ),
                            Text(
                              'LOGIN',
                              style: GoogleFonts.roboto(
                                  color: CustomColors.primaryColor,
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListTile(
                              title: Text(
                                'Sign in with phone',
                                style: GoogleFonts.roboto(
                                    color: CustomColors.primaryColor),
                              ),
                              leading: Radio(
                                  fillColor:
                                      const MaterialStatePropertyAll<Color>(
                                          CustomColors.primaryColor),
                                  value: SigninOptions.phone,
                                  groupValue: option,
                                  onChanged: (SigninOptions? value) {
                                    setState(() {
                                      option = value!;
                                    });
                                  }),
                            ),
                            option == SigninOptions.email
                                ? const EmailForm()
                                : const PhoneForm(hintText: 'Phone'),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const PasswordForm(hintText: 'Password'),
                            ListTile(
                              title: Text(
                                'Sign in with email',
                                style: GoogleFonts.roboto(
                                    color: CustomColors.primaryColor),
                              ),
                              leading: Radio(
                                  fillColor:
                                      const MaterialStatePropertyAll<Color>(
                                          CustomColors.primaryColor),
                                  value: SigninOptions.email,
                                  groupValue: option,
                                  onChanged: (SigninOptions? value) {
                                    setState(() {
                                      option = value!;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              height: 60.0,
                            ),
                            PrimaryCustomButton(
                              onpressed: () async {
                                if ((PhoneForm.formValue.isNotEmpty ||
                                        EmailForm.formValue.isNotEmpty) &&
                                    PasswordForm.formValue.isNotEmpty) {
                                  setState(() {
                                    LoginScreen.showScreen = false;
                                  });
                                  var data = {
                                    'phone': PhoneForm.formValue,
                                    'email': EmailForm.formValue,
                                    'passcode': PasswordForm.formValue
                                  };

                                  login(data, endpoints.login, context)
                                      .then((response) async {
                                    if (response.statusCode == 200) {
                                      //response from server is ok to log user in
                                      Navigator.of(context)
                                          .popAndPushNamed('/home');
                                      // await Future.delayed(
                                      //     const Duration(seconds: 3));
                                      // setState(() {
                                      //   LoginScreen.load = false;
                                      // });
                                      final accessToken =
                                          json.decode(response.body)['access'];
                                      //save access token on local storage
                                      //which will subsequently be use for authorization
                                      //on protected routes
                                      setData('access', accessToken);

                                      showMessage(
                                          json.decode(response.body)['message'],
                                          context);
                                    }
                                    //server rejection probably incorrect credentials
                                    if (response.statusCode == 401) {
                                      setState(() {
                                        LoginScreen.showScreen =
                                            true; //stop loading screen
                                        showMessage(
                                            json.decode(
                                                response.body)['message'],
                                            context);
                                      });
                                    }
                                    //bad request probably no such user on the platfrom
                                    if (response.statusCode == 400) {
                                      setState(() {
                                        LoginScreen.showScreen = true;
                                        EmailForm.formValue = '';
                                        PhoneForm.formValue = '';
                                        PasswordForm.formValue = '';
                                        showMessage(
                                            json.decode(
                                                response.body)['message'],
                                            context);
                                      });
                                    }
                                  }).catchError((err) {
                                    setState(() {
                                      LoginScreen.showScreen = true;
                                    });
                                  });
                                }
                              },
                              text: 'LOGIN',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Loading();
  }
}
