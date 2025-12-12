import 'package:flutter/material.dart';
import 'package:teamprogectfinal/model/maker.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/vm/makerdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class PlpPage extends StatefulWidget {
  const PlpPage({super.key});

  @override
  State<PlpPage> createState() => _PlpPageState();
}

class _PlpPageState extends State<PlpPage> {
  late int selectedCategory;
  late Makerdatabasehandler makerdatabasehandler;
  late Productdatabasehandler productdatabasehandler;

  @override
  void initState() {
    super.initState();
    makerdatabasehandler = Makerdatabasehandler();
    productdatabasehandler = Productdatabasehandler();
    selectedCategory = 0;
  }

  //페이지 기본 데이터 받아오기
  Future<({
    List<Maker> makerList,
    List<Product> productList,
  })> loadPageData() async {
    //DB 초기화
    await makerdatabasehandler.initializeDB();
    await productdatabasehandler.initializeDB();

    //리스트 데이터 받기
    final makerList = await makerdatabasehandler.queryMaker();
    final productList = await productdatabasehandler.queryProduct();

    return (
      makerList: makerList,
      productList: productList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전체 상품'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: loadPageData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) { //로딩 중
            return Center(child: CircularProgressIndicator());
          }
          List<Maker> makerList = snapshot.data!.makerList; //제조사 리스트
          List<Product> productList = snapshot.data!.productList; //제품 리스트
          if(selectedCategory == 0) selectedCategory = makerList[0].m_seq!; //선택된 제조사 초기화
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: makerList.map(
                    (e) {
                      return GestureDetector(
                        onTap: () { //선택된 제조사 변경
                          selectedCategory = e.m_seq!;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            style: TextStyle( //제조사 이름 버튼
                              color: selectedCategory == e.m_seq ? PColor.primaryColor : Colors.black,
                              fontWeight: selectedCategory == e.m_seq ? FontWeight.bold : FontWeight.normal,
                              fontSize: FontSize.productTitle
                            ),
                            e.m_name
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                child: GridView.builder( 
                  itemCount: productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ), 
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.memory(
                            productList[index].p_image
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.productTitle,
                              fontWeight: FontWeight.bold
                            ),
                            productList[index].m_seq.toString()
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.greylittle,
                              color: Colors.grey
                            ),
                            productList[index].p_name
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.productTitle,
                              fontWeight: FontWeight.bold
                            ),
                            productList[index].p_price.toString()
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
      ),
    );
  }
}