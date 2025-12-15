import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
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
  // value[4] = p_image
  // value[5] = m_name
  // value[6] = p_size

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
        backgroundColor: PColor.appBarBackgroundColor,
      ),
      backgroundColor: PColor.baseBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 구매 날짜
            Text(
              value[1],
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
              ),
            ),
            // 구매 번호
            Text(
              '구매번호 ${value[0]}'
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              '방문 수령 정보',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // 수령할 지점
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '수령 지점',
                  style: TextStyle(fontSize: 16),
                ),
                FutureBuilder(
                  future: handler.queryBranchAddress(value[0]),
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                    ? Text('${snapshot.data!['br_address']}\n${snapshot.data!['br_name']}')
                    : Center(
                      child: Text('데이터가 없습니다.'));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              '주문 상품',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.memory(value[4]),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value[5]),
                      Text(
                        '${value[6].substring(1)}',
                      ),
                      Text(
                        '${value[3].toString()}개',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              '결제 정보',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '상품 금액',
                  style: TextStyle(fontSize: 16),
                ),
                FutureBuilder(
                  future: handler.queryProductPrice(1, value[0]), // get argument로 구매번호 불러오기, u_seq 필요한지아닌지
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                    ? Text('${snapshot.data!}원')
                    : Center(
                      child: Text('데이터가 없습니다.'));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '구매 금액',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '${value[2]}원',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}