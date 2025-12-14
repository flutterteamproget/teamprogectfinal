import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/view/pdp_page.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Productdatabasehandler phandler;

  @override
  void initState() {
    super.initState();
    phandler = Productdatabasehandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded( 
            child: FutureBuilder(
              future: phandler.queryProductByMaker(),
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data!.isNotEmpty
                    ? GridView.builder(
                      
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 230,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(PdpPage(),
                            arguments: [
                              snapshot.data![index].p_name,
                              snapshot.data![index].p_price,
                              snapshot.data![index].p_image,
                              snapshot.data![index].p_seq,



                            ]),
                            child: Card(
                              
                              child: Column(
                                children: [
                                  Image.memory(snapshot.data![index].p_image),
                                  Text(" ${snapshot.data![index].p_name}"),
                                  Text(" ${snapshot.data![index].p_price}원")
                                ],
                              ),
                             
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("등록된 상품이 없습니다"),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
