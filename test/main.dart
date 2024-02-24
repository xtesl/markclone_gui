import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markclone/material_app.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Initialize flutter engine before serving

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MarkClone());
  });
}
