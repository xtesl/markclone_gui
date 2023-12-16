/*
This file defines custom forms for the app
==========================================
*Author:Asare Emmanuel

*Date:Unknown

*Lincense:MIT

*(C) 2023.All rights reserved
*/

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/constants/colors.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final controller = TextEditingController();
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              controller.text = value.trim();
            });
          },
          controller: controller,
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.email_rounded),
              ),
              suffixIcon: controller.text.isNotEmpty &&
                      emailRegex.hasMatch(controller.text)
                  ? const Icon(Icons.done, color: Colors.green)
                  : null,
              error: (controller.text.isNotEmpty) &&
                      !emailRegex.hasMatch(controller.text)
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text(
                            'Please enter a valid email',
                            style: GoogleFonts.roboto(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : null,
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              suffixStyle: const TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: CustomColors.primaryColor,
                ),
              ),
              hintText: 'Email'),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  final String hintText;
  const PasswordForm({super.key, required this.hintText});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final controller = TextEditingController();
  final passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{6,}$');
  String? hintText;
  bool? show;
  static int counter = 0;
  IconData showPasswordIcon = Icons.visibility;

  @override
  void initState() {
    hintText = widget.hintText;
    show = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          obscureText: !show!,
          onChanged: (value) {
            setState(() {
              controller.text = value;
              if (controller.text.isEmpty) {
                show = false;
                showPasswordIcon = Icons.visibility;
                counter = 0;
              }
            });
          },
          controller: controller,
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.lock),
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          counter += 1;
                          if (counter % 2 == 0) {
                            show = false;
                            showPasswordIcon = Icons.visibility;
                          } else {
                            show = true;
                            showPasswordIcon = Icons.visibility_off;
                          }
                        });
                      },
                      icon: Icon(
                        showPasswordIcon,
                        color: Colors.black,
                      ))
                  : null,
              error: (controller.text.isNotEmpty) &&
                      !passwordRegex.hasMatch(controller.text)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Column(children: [
                          Text(
                            'Password must contains:',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least one uppercase letter[A-Z]',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least one lowercase letter[a-z]',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least one special character[=.*[!@#/)+-]',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least six letters',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                        ])
                      ],
                    )
                  : null,
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              suffixStyle: const TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: CustomColors.primaryColor,
                ),
              ),
              hintText: hintText),
        ),
      ),
    );
  }
}

class PhonesignupForm extends StatefulWidget {
  const PhonesignupForm({super.key});

  @override
  State<PhonesignupForm> createState() => _PhonesignupFormState();
}

class _PhonesignupFormState extends State<PhonesignupForm> {
  final controller = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: '233',
      countryCode: 'GH',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Ghana',
      example: 'Ghana',
      displayName: 'Ghana',
      displayNameNoCountryCode: 'GH',
      e164Key: '');
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.length <= 10) {
              setState(() {
                controller.text = value;
              });
            } else {
              setState(() {
                controller.text =
                    controller.text.substring(0, 10); //Gh phone maxLength is 10
              });
            }
          },
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20.0),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              prefixIcon: Container(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: const CountryListThemeData(
                              bottomSheetHeight: 500.0),
                          onSelect: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          });
                    },
                    child: Text(
                      "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor))),
        ),
      ),
    );
  }
}
