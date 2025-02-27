import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/animated_splash.dart';
import 'pages/signin.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return MaterialApp(
        title: 'Document Uploader',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: AnimatedSplash(
          logoText: 'Document Uploader',
          imagePath: 'assets/images/splash.png',
          home: SigninPage(),
          duration: 2000,
          runfor: AnimatedSplashType.StaticDuration,
        ),
      );
  }
}
