import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rss/compostion_root.dart';
import 'package:rss/presentation/ress_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/get_it.dart' as getIt;

SharedPreferences? globalSharedPrefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(getIt.init());
  await CompositionRoot.configure();
  globalSharedPrefs = await SharedPreferences.getInstance();
  final screenToShow = await CompositionRoot.start();
  runApp(RessApp(screenToShow));
}
