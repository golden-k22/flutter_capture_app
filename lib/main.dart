import 'package:flutter/material.dart';
import 'package:photo_pdf/app.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:photo_pdf/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  runApp(const App());
}
