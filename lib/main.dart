import 'package:flutter/material.dart';
import 'package:rest_api/Screens/complex_json.dart';
import 'package:rest_api/Screens/complex_wo_model.dart';
import 'package:rest_api/Screens/example_2.dart';
import 'package:rest_api/Screens/signUp_screen.dart';
import 'package:rest_api/Screens/upload_image.dart';


import 'Screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REST APIs',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImageScreen(),
    );
  }
}


