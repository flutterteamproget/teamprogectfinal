import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/view/drawerpage.dart';
import 'package:teamprogectfinal/view/home.dart';
import 'package:teamprogectfinal/view/main_page.dart';
import 'package:teamprogectfinal/view/my_page.dart';
import 'package:teamprogectfinal/view/pdp_page.dart';
import 'package:teamprogectfinal/view/plp_drawer_page.dart';
import 'package:teamprogectfinal/view/plp_page.dart';
import 'package:teamprogectfinal/view/tabbarview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
     
      home: const MyPage(),
    );
  }
}

