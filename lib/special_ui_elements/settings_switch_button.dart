import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//settings switch button providers
class SwitchButtonDataModel with ChangeNotifier {
  final String settingName;
  SwitchButtonDataModel({required this.settingName});
  bool _switchValue = false;
  bool get getSwitchValue => _switchValue;

  Future<void> loadSwitchValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _switchValue = sharedPreferences.getBool(settingName) ?? false;
  }

  Future<void> setSwitchValue(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(settingName, value);
    _switchValue = value;
    notifyListeners();
  }
}

//individual hild switch buttons
class LocationSwitchButtonDataModel extends SwitchButtonDataModel {
  LocationSwitchButtonDataModel() : super(settingName: 'isLocationAllowed');
}

class PushNotificationSwitchButtonDataModel extends SwitchButtonDataModel {
  PushNotificationSwitchButtonDataModel()
      : super(settingName: 'isPushNotificationAllowed');
}

class EmailNotificationSwitchButtonDataModel extends SwitchButtonDataModel {
  EmailNotificationSwitchButtonDataModel()
      : super(settingName: 'isEmailNotificationsAllowed');
}

class SwitchButton extends StatelessWidget {
  final bool switchValue;
  final Function(bool) onChanged;
  const SwitchButton(
      {super.key, required this.switchValue, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: switchValue,
      onChanged: onChanged,
    );
  }
}
