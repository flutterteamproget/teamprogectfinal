import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/view/buydetail.dart';
import 'package:teamprogectfinal/view/home.dart';
import 'package:teamprogectfinal/view/login.dart';
import 'package:teamprogectfinal/view/my_update.dart';
import 'package:teamprogectfinal/vm/buydatabasehandler.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Logindatabasehandler handler;
  late Buydatabasehandler bHandler;

  @override
  void initState() {
    super.initState();
    handler = Logindatabasehandler();
    bHandler = Buydatabasehandler();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor
      ),
      body: FutureBuilder(
        future: handler.queryUser(),
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.widthOf(context),
                          height: 280,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircleAvatar(
                                      backgroundImage: MemoryImage(snapshot.data![index].u_image!),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data![index].u_name}님 환영합니다.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 5, 0,),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                            MyUpdate(),
                                            arguments: [
                                              snapshot.data![index].u_seq,
                                              snapshot.data![index].u_name,
                                              snapshot.data![index].u_id,
                                              snapshot.data![index].u_phone,
                                              snapshot.data![index].u_image,
                                            ]
                                          )!.then((value) => reloadData());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromRGBO(51, 51, 51, 1,),
                                        ),
                                        child: Text(
                                          '회원정보 수정',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0,),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(Home());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromRGBO(51, 51, 51, 1,),
                                        ),
                                        child: Text(
                                          '로그아웃',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('구매 내역'),
                        ),
                    FutureBuilder(
                      future: bHandler.queryBuyDate(1), // <- 1 대신 구매번호 b_seq 불러오기
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? Text(snapshot.data!)
                        : Center(
                          child: Text('데이터가 없습니다.'));
                      },
                    ),
                    FutureBuilder(
                      future: bHandler.queryBuyProduct(1), // <- 1 대신 구매번호 b_seq 불러오기
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: PColor.baseBackgroundColor,
                              shadowColor: Colors.transparent,
                              child: Column(
                                children: [
                                  Text(snapshot.data![index].b_date),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                        Buydetail(),
                                        arguments: [
                                          snapshot.data![index].b_seq,
                                          snapshot.data![index].b_date,
                                          snapshot.data![index].b_price,
                                          snapshot.data![index].b_quantity,
                                        ]
                                      );
                                    }, 
                                  child: Text('구매 상세')),
                                  Text(
                                    '''
                                      (제조사 m_name)
                                      (상품명 p_name)
                                      (사이즈 p_size, ${snapshot.data![index].b_quantity})
                                      ${snapshot.data![index].b_price}
                                    '''
                                  )
                                ],
                              ),
                            );
                          }
                        )
                        : Center(
                          child: Text('데이터가 없습니다.')
                        );
                      },),
                        Divider(color: PColor.borderColor),
                      ],
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }//build

reloadData(){
    handler.queryUser();
    setState(() {});

  }



}//class
