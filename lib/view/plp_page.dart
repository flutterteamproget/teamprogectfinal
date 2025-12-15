import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/maker.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/view/pdp_page.dart';
import 'package:teamprogectfinal/vm/makerdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class PlpPage extends StatefulWidget {
  final int uSeq;
  const PlpPage({super.key,required this.uSeq});

  @override
  State<PlpPage> createState() => _PlpPageState();
}

class _PlpPageState extends State<PlpPage> {
  late int selectedCategory;
  late bool isSearching;
  late String selectedOrder;
  late List<String> orderList;
  late Makerdatabasehandler makerdatabasehandler;
  late Productdatabasehandler productdatabasehandler;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    makerdatabasehandler = Makerdatabasehandler();
    productdatabasehandler = Productdatabasehandler();
    searchController = TextEditingController();
    selectedCategory = 0;
    isSearching = false;
    selectedOrder = "이름순";
    orderList = ["이름순", "가격 높은순", "가격 낮은순", "브랜드순", "구매순"];
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
    List<Product> productList;
    
    if(isSearching){ //검색 중일 경우
      productList = await productdatabasehandler.queryProductSearch(searchController.text, selectedOrder);
    }else{
      if(selectedCategory == 0){//선택된 카테고리에 따라 제품 보여주기
        productList = await productdatabasehandler.queryProduct(selectedOrder);
      }else if(selectedCategory == 1){
        productList = await productdatabasehandler.queryProductCategory('m_seq', 1, selectedOrder);
      }else if(selectedCategory == 2){
        productList = await productdatabasehandler.queryProductCategory('m_seq', 2, selectedOrder);
      }else if(selectedCategory == 3){
        productList = await productdatabasehandler.queryProductCategory('m_seq', 3, selectedOrder);
      }else{
        productList = await productdatabasehandler.queryProductCategory('m_seq', 4, selectedOrder);
      }
    }

    return (
      makerList: makerList,
      productList: productList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              List<Maker> makerList = snapshot.data!.makerList; //제조사 리스트
              List<Product> productList = snapshot.data!.productList; //제품 리스트
              return Column(
                children: [
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
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: makerList.map(
                        (e) {
                          return GestureDetector(
                            onTap: () { //선택된 제조사 변경
                              isSearching = false;
                              if(selectedCategory == e.m_seq){
                                selectedCategory = 0;
                              }else{
                                selectedCategory = e.m_seq!;
                              }
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
                        childAspectRatio: 0.55,
                      ), 
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Get.to(PdpPage(),
                              arguments: [
                                productList[index].p_name,
                                productList[index].p_price,
                                productList[index].p_image,
                                productList[index].p_seq,
                                widget.uSeq,
                                productList[index].m_seq
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
                                  " ${productList[index].m_name!}",
                                ),
                                Text(
                                  style: TextStyle(
                                    fontSize: FontSize.greylittle,
                                    color: Colors.grey,
                                  ),
                                  productList[index].p_name,
                                  textAlign: TextAlign.start,
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
      ),
    );
  }
}