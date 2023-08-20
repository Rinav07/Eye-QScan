import 'package:flutter/material.dart';
import 'package:q_eyedefender/screens/uploadscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Manrope-VariableFont_wght',
        ),
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: UploadScreen(),),
      ),
    );
  }
}
