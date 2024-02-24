import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/home/Acount/profile_info.dart';
import 'package:markclone/special_ui_elements/animation_visuals.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/settings_switch_button.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    // bool settingState = snapshot.data ?? false;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            SecondaryCustomButton(
              onpressed: () {},
              text: 'Sell',
              width: 120.0,
            ),
            SizedBox(
              width: screenDimensions['width']! * 0.01,
            ),
            SecondaryCustomButton(
              onpressed: () {},
              text: "Log out",
              width: 120.0,
            )
          ],
          backgroundColor: Colors.black,
        ),
        backgroundColor: const Color.fromRGBO(230, 230, 230, 1.0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Material(
                    elevation: 6.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: screenDimensions['width']! * 0.55),
                            child: Text(
                              'General Settings',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenDimensions['width']! * 0.04),
                            ),
                          ),
                          SizedBox(
                            height: screenDimensions['height']! * 0.03,
                          ),
                          Consumer<ProfileImageModel>(
                              builder: (context, model, child) => ListTile(
                                    title: const Text('Profile'),
                                    subtitle:
                                        const Text('Edit profile information'),
                                    trailing: V3CustomButton(onpressed: () {
                                      Navigator.of(context).push(
                                          customPageRoute_2(
                                              const ProfileInfo()));
                                    }),
                                  )),
                          const Divider(),

                          ListTile(
                              trailing: Consumer<
                                  PushNotificationSwitchButtonDataModel>(
                                builder: (context, model, child) {
                                  return SwitchButton(
                                      switchValue: model.getSwitchValue,
                                      onChanged: (value) async {
                                        await model.setSwitchValue(value);
                                      });
                                },
                              ),
                              // overlayColor:
                              //     MaterialStatePropertyAll<Color>(Colors.white),
                              title: const Text('Push Notifications'),
                              subtitle: const Text(
                                'Allow MingleCart to send push notifications to your device',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              )),
                          //
                          const Divider(),
                          ListTile(
                            trailing: Consumer<
                                    EmailNotificationSwitchButtonDataModel>(
                                builder: (context, model, child) {
                              return SwitchButton(
                                  switchValue: model.getSwitchValue,
                                  onChanged: (value) async {
                                    await model.setSwitchValue(value);
                                  });
                            }),
                            //     MaterialStatePropertyAll<Color>(Colors.white),
                            title: const Text('Email Notifications'),
                            subtitle: const Text(
                              'Allow MingleCart to send you emails',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                          ListTile(
                            trailing: Consumer<LocationSwitchButtonDataModel>(
                                builder: (context, model, child) {
                              return SwitchButton(
                                  switchValue: model.getSwitchValue,
                                  onChanged: (value) async {
                                    await model.setSwitchValue(value);
                                  });
                            }),
                            //     MaterialStatePropertyAll<Color>(Colors.white),
                            title: const Text('Location'),
                            subtitle: const Text(
                              'Allow MingleCart to access your location data',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: screenDimensions['height']! * 0.1,
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Material(
                    elevation: 6.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: screenDimensions['width']! * 0.72),
                            child: Text(
                              'Support',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenDimensions['width']! * 0.04),
                            ),
                          ),
                          ListTile(
                            title: const Text('Terms of Service'),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text('Data Policy'),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text('About'),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text('FAQ'),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text('Contact us'),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MySwitchButton extends StatefulWidget {
  const MySwitchButton({super.key});

  @override
  State<MySwitchButton> createState() => _MySwitchButtonState();
}

class _MySwitchButtonState extends State<MySwitchButton> {
  bool value = false;
  @override
  void initState() {
    super.initState();
    fetchSettings();
  }

  Future<bool?> getDataBool(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  Future<void> setDataBool(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  Future<void> fetchSettings() async {
    value = await getDataBool('isLocationAccessAllowed') ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: (bool value) async {
        //stores user prefs sharedprefs
        setState(() {
          this.value = value;
        });
        await setDataBool('isLocationAccessAllowed', value);
      },
      activeTrackColor: CustomColors.primaryColor,
      inactiveThumbColor: Colors.white,
      trackOutlineColor: const MaterialStatePropertyAll<Color>(Colors.white),
      // overlayColor:
      //     MaterialStatePropertyAll<Color>(Colors.white),
      title: const Text('Location Settings'),
      subtitle: const Text(
        'Edit your profile',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }
}
