
import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/providers/inbox_provider.dart';
import 'package:canine_castle_mobile/providers/search_provider.dart';
import 'package:canine_castle_mobile/providers/state_and_city_provider.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'app/my_app.dart';
import 'models/hive_models/hive_user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: mainColor, // navigation bar color
    statusBarColor: mainColor, // status bar color
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(HiveUserModelAdapter());
  await Hive.openBox<HiveUserModel>(userBox);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StateAndCityProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => SearchProvider()),
      ChangeNotifierProvider(create: (context) => InboxProvider()),
    ],
    child: const MyApp(),
  ));
}
