import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:live_tv/common/constants/language_constants.dart';
import 'package:live_tv/common/injector/injector.dart';
import 'package:live_tv/services/stromp_services.dart';
import 'package:live_tv/view/app.dart';

Future<void> main() async {
  Injector.setup();
  WidgetsFlutterBinding.ensureInitialized();
  StompServices.instance.client.activate();
  Stripe.publishableKey =
      'pk_test_51JZ6qTHyalbYzdTRIelpxU15nn8YAUXupVgem5KZvhayqiSHgu8jihcEhIjct6BxAcNxz7CvABeOK55HlMrOUdLN00xk3Oox3O';
  final delegate = await LocalizationDelegate.create(
      fallbackLocale: LanguageConstants.vn,
      supportedLocales: [LanguageConstants.en, LanguageConstants.vn]);
  runApp(LocalizedApp(delegate, App()));
}

// // main.dart
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // set the publishable key for Stripe - this is mandatory
//   Stripe.publishableKey =
//       'pk_test_51JZ6qTHyalbYzdTRIelpxU15nn8YAUXupVgem5KZvhayqiSHgu8jihcEhIjct6BxAcNxz7CvABeOK55HlMrOUdLN00xk3Oox3O';
//   runApp(MaterialApp(
//     home: PaymentScreen(),
//   ));
// }
