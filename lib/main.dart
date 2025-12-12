import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/view/home.dart';
import 'package:teamprogectfinal/view/staff_insert_product.dart';
import 'package:teamprogectfinal/view/staff_login.dart';
import 'package:teamprogectfinal/view/staff_mainpage.dart';
import 'package:teamprogectfinal/view/staff_mainpagesuper.dart';

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
      home: const StaffInsertProduct(),
    );
  }
}

