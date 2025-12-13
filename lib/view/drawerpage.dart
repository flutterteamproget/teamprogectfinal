import 'package:flutter/material.dart';
import 'package:teamprogectfinal/vm/genderdatabasehandler.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  late Logindatabasehandler lHandler;
  late Genderdatabasehandler gHandler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lHandler = Logindatabasehandler();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: FutureBuilder(
              future: lHandler.queryUser2('u_name', 1), // 수정 예정
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data!.isNotEmpty
                ? Text('상품 금액 ${snapshot.data!}원')
                : Center(
                  child: Text('데이터가 없습니다.'));
              },
            ),
              accountEmail: Text('test@gmail.com'),
            ),
            ExpansionTile(
              title: Text('MEN'),
              children: [
                ListTile(
                  title: Text('스니커즈'),
                  onTap: () {
                    // 페이지 이동
                  },
                ),
                ListTile(
                  title: Text('캐주얼'),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  title: Text('test'),
                  onTap: () {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}