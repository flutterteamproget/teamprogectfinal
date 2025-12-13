import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/vm/buydatabasehandler.dart';

class Buydetail extends StatefulWidget {
  const Buydetail({super.key});

  @override
  State<Buydetail> createState() => _BuydetailState();
}
/*
  int? b_seq;
  int? br_seq;
  int? u_seq;
  int? p_seq;
  String b_date;
  String b_price;
*/
class _BuydetailState extends State<Buydetail> {
  late Buydatabasehandler handler;
  var value = Get.arguments ?? '____';
  // value[0] = b_seq
  // value[1] = b_date
  // value[2] = b_price
  // value[3] = b_quantity

  @override
  void initState() {
    
    super.initState();
    handler = Buydatabasehandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('구매 상세'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value[1].toString().substring(0,10)), // 구매 날짜
            Text('구매 번호 ${value[0]}'),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Text('방문 수령 정보'),
            FutureBuilder(
              future: handler.queryBranchAddress(value[0]), // get argument로 구매번호 불러오기
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data!.isNotEmpty
                ? Text('수령 지점 ${snapshot.data!}')
                : Center(
                  child: Text('데이터가 없습니다.'));
              },
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Text('주문 상품 ${value[3]}개'),
            // get argument로 listview
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Text('결제 정보'),
            FutureBuilder(
              future: handler.queryProductPrice(value[0]), // get argument로 구매번호 불러오기
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data!.isNotEmpty
                ? Text('상품 금액 ${snapshot.data!}원')
                : Center(
                  child: Text('데이터가 없습니다.'));
              },
            ),
            Text('구매 금액 ${value[2]}원')
          ],
        ),
      ),
    );
  }
}