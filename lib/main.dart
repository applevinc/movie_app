import 'package:flutter/material.dart';
import 'package:movie_app/src/app.dart';
import 'package:movie_app/src/service_locator.dart' as service_locator;

void main() async {
  await service_locator.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
