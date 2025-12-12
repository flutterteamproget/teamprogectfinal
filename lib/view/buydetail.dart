import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/buy.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
            FutureBuilder(
              future: handler.queryBuyDate(1), 
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data!.isNotEmpty
                ? Text(snapshot.data!)
                : Center(
                  child: CircularProgressIndicator());
              },
            ),
          ],
          
        ),
      ),
    );
  }
}