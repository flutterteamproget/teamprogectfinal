import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/category_gender.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/view/pdp_page.dart';
import 'package:teamprogectfinal/vm/genderdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int selectedCategory;
  late bool isSearching;
  late Genderdatabasehandler genderdatabasehandler;
  late Productdatabasehandler productdatabasehandler;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    genderdatabasehandler = Genderdatabasehandler();
    productdatabasehandler = Productdatabasehandler();
    searchController = TextEditingController();
    selectedCategory = 0;
    isSearching = false;
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
    List<Product> productList;
    
    if(isSearching){ //검색 중일 경우
      productList = await productdatabasehandler.queryProductSearch(searchController.text);
    }else{
      if(selectedCategory == 0){//선택된 카테고리에 따라 제품 보여주기
        productList = await productdatabasehandler.queryProduct();
      }else if(selectedCategory == 1){
        productList = await productdatabasehandler.queryProductCategory('m_seq', 1);
      }else{
        productList = await productdatabasehandler.queryProductCategory('m_seq', 2);
      }
    }

    return (
      genderList: genderList,
      productList: productList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('전체 상품'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: loadPageData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) { //로딩 중
              return Center(child: CircularProgressIndicator());
            }
            List<CategoryGender> makerList = snapshot.data!.genderList; //제조사 리스트
            List<Product> productList = snapshot.data!.productList; //제품 리스트
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: '검색어를 입력하세요',
                    isDense: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        selectedCategory = 0;
                        isSearching = true;
                        setState(() {});
                      }, 
                      icon: Icon(Icons.search)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    // 자동검색
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: makerList.map(
                      (e) {
                        return GestureDetector(
                          onTap: () { //선택된 제조사 변경
                            isSearching = false;
                            if(selectedCategory == e.gc_seq){
                              selectedCategory = 0;
                            }else{
                              selectedCategory = e.gc_seq!;
                            }
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              style: TextStyle( //제조사 이름 버튼
                                color: selectedCategory == e.gc_seq ? PColor.primaryColor : Colors.black,
                                fontWeight: selectedCategory == e.gc_seq ? FontWeight.bold : FontWeight.normal,
                                fontSize: FontSize.productTitle
                              ),
                              e.gc_name
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
                      childAspectRatio: 0.55,
                    ), 
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.to(PdpPage(),
                            arguments: [
                              productList[index].p_name,
                              productList[index].p_price,
                              productList[index].p_image,
                            ]),
                        child: Container(
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
                                productList[index].m_name!
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
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}