import 'package:flutter/material.dart';
import 'package:natural_app/init.dart' as di;
import 'package:natural_app/src/app.dart';

void main() async {
  await di.init();
  
  runApp(const App());
}