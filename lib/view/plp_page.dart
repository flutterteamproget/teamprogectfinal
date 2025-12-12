import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:teamprogectfinal/model/category_gender.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/vm/genderdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class PlpPage extends StatefulWidget {
  const PlpPage({super.key});

  @override
  State<PlpPage> createState() => _PlpPageState();
}

class _PlpPageState extends State<PlpPage> {
  List<String> list = ['나이키','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19'];
  late int selectedCategory;
  late Genderdatabasehandler genderdatabasehandler;
  late Productdatabasehandler productdatabasehandler;

  @override
  void initState() {
    super.initState();
    genderdatabasehandler = Genderdatabasehandler();
    productdatabasehandler = Productdatabasehandler();
  }

  //페이지 기본 데이터 받아오기
  Future<({
    List<CategoryGender> genderList,
    List<Product> productList,
  })> loadPageData() async {
    //DB 초기화
    await genderdatabasehandler.initializeDB();
    await productdatabasehandler.initializeDB();

    //리스트 데이터 받기
    final genderList = await genderdatabasehandler.queryGender();
    print(genderList);
    final productList = await productdatabasehandler.queryProduct();

    return (
      genderList: genderList,
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
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<CategoryGender> genderList = snapshot.data!.genderList;
          List<Product> productList = snapshot.data!.productList;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: genderList.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        style: TextStyle(
                          fontSize: FontSize.productTitle
                        ),
                        e.gc_name
                      ),
                    );
                  },
                ).toList(),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: list.length,
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
                          Text(
                            list[index]
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.productTitle,
                              fontWeight: FontWeight.bold
                            ),
                            list[index]
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.greylittle,
                              color: Colors.grey
                            ),
                            list[index]
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.productTitle,
                              fontWeight: FontWeight.bold
                            ),
                            list[index]
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