import 'package:flutter/material.dart';
import 'package:natural_app/app/init/init.dart' as di;
import 'package:natural_app/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}