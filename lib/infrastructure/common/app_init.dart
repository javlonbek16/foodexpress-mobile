import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodexpress_mobile/infrastructure/di/injection_container.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  //!local storage, firebase, localization initializelarni ham mana shu yerda qilaman!
  await dotenv.load(fileName: ".env");
  await setupLocator();
}
