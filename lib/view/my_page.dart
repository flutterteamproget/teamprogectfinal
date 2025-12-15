import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/view/buydetail.dart';
import 'package:teamprogectfinal/view/home.dart';
import 'package:teamprogectfinal/view/my_update.dart';
import 'package:teamprogectfinal/vm/buydatabasehandler.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Logindatabasehandler loginHandler;
  late Buydatabasehandler buyHandler;

  @override
  void initState() {
    super.initState();
    loginHandler = Logindatabasehandler();
    buyHandler = Buydatabasehandler();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor
      ),
      body: FutureBuilder(
        future: loginHandler.queryUser2(1),
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data!.isNotEmpty
              ? Column(
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
                                      backgroundImage: MemoryImage(snapshot.data!['u_image'] as Uint8List),
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!['u_name']}님 환영합니다.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
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
                                              snapshot.data!['u_seq'],
                                              snapshot.data!['u_name'],
                                              snapshot.data!['u_id'],
                                              snapshot.data!['u_phone'],
                                              snapshot.data!['u_image']
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
                        Divider(color: PColor.borderColor),
                        ExpansionTile(
                          title: Text(
                            '통계',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [

                        // 선호 메이커
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: FutureBuilder(
                            future: buyHandler.queryFavoriteMaker(), 
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot.data!.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('선호 메이커'),
                                    Text('1위 ${snapshot.data![0]['m_name']}, 구매 횟수 ${snapshot.data![0]['count(m.m_seq)']}'),
                                    Text('2위 ${snapshot.data![1]['m_name']}, 구매 횟수 ${snapshot.data![1]['count(m.m_seq)']}'),
                                  ],
                              )
                              : Text('불러올 데이터가 없습니다.');
                            }
                          ),
                        ),
                        // 최다 방문 지점
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: FutureBuilder(
                            future: buyHandler.queryBranchVisit(), 
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot.data!.isNotEmpty
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('\n최다 방문 지점'),
                                  Text('${snapshot.data!['br_name']} 방문 횟수: ${snapshot.data!['count(b.br_seq)']}번'),
                                ],
                              )
                              : Text('불러올 데이터가 없습니다.');
                            }
                          ),
                        ),
                        // 구매액 최대
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: FutureBuilder(
                            future: buyHandler.queryBranchPrice(), 
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot.data!.isNotEmpty
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('\n최대 지출 지점'),
                                  Text('${snapshot.data!['br_name']} 구매액: ${snapshot.data!['sum(b_price)']}원'),
                                ],
                              )
                              : Text('불러올 데이터가 없습니다.');
                            }
                          ),
                        ),

                          ],),
                          Divider(color: PColor.borderColor),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '구매 내역',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(color: PColor.borderColor),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FutureBuilder(
                          future: buyHandler.queryBuy2(1), // <- 1 대신 u_seq 불러오기
                          builder: (context, snapshot) {
                            return snapshot.hasData && snapshot.data!.isNotEmpty
                            ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                late String maker;
                                switch (snapshot.data![index]['m_seq']){
                                  case 1:
                                  maker = '누오보';
                                  case 2:
                                  maker = '스테파노로시';
                                  case 3:
                                  maker = '반스';
                                  case 4:
                                  maker = '에이비씨 셀렉트';
                                }
                                return Card(
                                  color: PColor.baseBackgroundColor,
                                  shadowColor: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data![index]['b_date'],
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.to(
                                                Buydetail(),
                                                arguments: [
                                                  snapshot.data![index]['b_seq'],
                                                  snapshot.data![index]['b_date'],
                                                  snapshot.data![index]['b_price'],
                                                  snapshot.data![index]['b_quantity'],
                                                  snapshot.data![index]['p_image'],
                                                  maker,
                                                  snapshot.data![index]['p_name'],
                                                  snapshot.data![index]['p_size'],

                                                ]
                                              );
                                            }, 
                                            child: Text(
                                              '구매 상세',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                            
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: Image.memory(snapshot.data![index]['p_image'],),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(maker, style: TextStyle(fontWeight: FontWeight.bold),),
                                                Text('${snapshot.data![index]['p_name']}'.substring(1)),
                                                Text(
                                                  '${snapshot.data![index]['p_size']} / ${snapshot.data![index]['b_quantity']}개',
                                                  style: TextStyle(
                                                    fontSize: FontSize.greylittle,
                                                    color: Colors.grey
                                                  ),
                                                ),
                                                Text(
                                                  '${snapshot.data![index]['b_price'].toString()}원',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Divider()
                                    ],
                                  ),
                                );
                              }
                            )
                            : Center(
                              child: Text('데이터가 없습니다.')
                            );
                          },),
                      ),
                    ),
                        Divider(color: PColor.borderColor),
                      ],
                    )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }//build

reloadData(){
    loginHandler.queryUser();
    setState(() {});

  }

favoriteBranch(AsyncSnapshot snapshot){
  snapshot.data!['br_name'];
}



}//class
