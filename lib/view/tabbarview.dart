import 'package:flutter/material.dart';
import 'package:teamprogectfinal/view/main_page.dart';
import 'package:teamprogectfinal/view/my_page.dart';
import 'package:teamprogectfinal/view/plp_page.dart';

class Tabbarview extends StatefulWidget {
  final int useq;
  const Tabbarview({super.key,
  required this.useq});

  @override
  State<Tabbarview> createState() => _TabbarviewState();
}

class _TabbarviewState extends State<Tabbarview>with SingleTickerProviderStateMixin  {

  late TabController controller;

  @override
  void initState() {
    super.initState();
  controller= TabController(length: 3, vsync: this);
}
    @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          MainPage(uSeq:widget.useq,),
          MyPage(),
          PlpPage()

        ]),

        bottomNavigationBar: Container(
          color: Colors.white,
          height: 80,
          child: TabBar(
            controller: controller,
            
            tabs: [
          Tab(
            icon: Icon(Icons.home,
            color: Colors.black,
            ),
            text: "Home",
            
          ),
          Tab(
            icon: Icon(Icons.face,
            color: Colors.black,),
            text: "마이",
            
          ),
          Tab(
            icon: Icon(Icons.menu,
            color: Colors.black,),
            text: "메뉴",
            
          ),
          
          ]),
        ),


    );
  }
}