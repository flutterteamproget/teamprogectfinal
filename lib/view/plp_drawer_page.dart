import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/maker.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/view/pdp_page.dart';
import 'package:teamprogectfinal/vm/makerdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class PlpDrawerPage extends StatefulWidget {
  const PlpDrawerPage({super.key});

  @override
  State<PlpDrawerPage> createState() => _PlpDrawerPageState();
}

class _PlpDrawerPageState extends State<PlpDrawerPage> {
  late int selectedCategory;
  late bool isSearching;
  late String selectedOrder;
  late List<String> orderList;
  late Productdatabasehandler productdatabasehandler;
  late TextEditingController searchController;

  List<List> value = Get.arguments ?? []; //drawer에서 [카테고리 컬럼명, 시퀀스 값] 리스트 받아옴

  @override
  void initState() {
    super.initState();
    productdatabasehandler = Productdatabasehandler();
    searchController = TextEditingController();
    selectedCategory = 0;
    isSearching = false;
    selectedOrder = "이름순";
    orderList = ["이름순", "가격 높은순", "가격 낮은순", "브랜드순"];
  }

  //페이지 기본 데이터 받아오기
  Future<({
    List<Product> productList,
  })> loadPageData() async {
    //DB 초기화
    await productdatabasehandler.initializeDB();

    //리스트 데이터 받기
    List<Product> productList;
    
    if(isSearching){ //검색 중일 경우
      productList = await productdatabasehandler.queryProductSearch(searchController.text, selectedOrder);
    }else{
      if (value[0][0] == "m_seq"){ //브랜드 명을 눌렀을 경우
        productList = await productdatabasehandler.queryProductCategory(value[0][0], value[0][1], selectedOrder);
      }else{ //종류를 눌렀을 경우
        productList = await productdatabasehandler.queryProductCategoryTwo(value[0][0], value[0][1], value[1][0], value[1][1], selectedOrder);
      }
    }

    return (
      productList: productList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            List<Product> productList = snapshot.data!.productList; //제품 리스트
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    value[value.length-1][0],
                    style: TextStyle(
                      fontSize: FontSize.productTitle
                    ),                  
                  ),
                ),
                TextField(
                  controller: searchController,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("총 "),
                          Text(
                            productList.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PColor.primaryColor
                            ),
                          ),
                          Text("개")
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        height: 30,
                        child: DropdownButtonFormField<String>( //정렬 드롭다운
                          initialValue: selectedOrder,
                          isDense: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          items: orderList.map(
                            (e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: FontSize.greylittle
                                  ),
                                  ),
                              );
                            }
                          ).toList(), 
                          onChanged: (value) {
                            selectedOrder = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.memory(
                                productList[index].p_image
                              ),
                              Text(
                                style: TextStyle(
                                  fontSize: FontSize.productTitle,
                                  fontWeight: FontWeight.bold
                                ),
                                " ${productList[index].m_name!}"
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
                                " ${productList[index].p_price.toString()}"
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