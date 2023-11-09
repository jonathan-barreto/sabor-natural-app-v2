import 'package:flutter/services.dart';

abstract interface class DebounceService {
  void call(VoidCallback run);
}