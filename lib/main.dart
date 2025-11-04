import 'package:final_project_dlny/provider/userprovider.dart';
import 'package:final_project_dlny/screens/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
        ChangeNotifierProvider(create: (_)  => UserProvider(),
      child: MyApp()

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
