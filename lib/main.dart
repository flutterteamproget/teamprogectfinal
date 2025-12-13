import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/view/drawerpage.dart';
import 'package:teamprogectfinal/view/my_page.dart';
import 'package:teamprogectfinal/view/staff_insert_product.dart';
import 'package:teamprogectfinal/view/tabbarview.dart';
// import 'package:teamprogectfinal/view/my_update.dart';

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
     
      home: const Drawerpage(),
    );
  }
}

