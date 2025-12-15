import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teamprogectfinal/model/category_gender.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/view/pdp_page.dart';
import 'package:teamprogectfinal/vm/genderdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class MainPage extends StatefulWidget {
  final int uSeq;
  const MainPage({super.key,required this.uSeq});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   List<String> bannerImages = [
  'images/main_banner_01.jpg',
  'images/main_banner_02.jpg',
  'images/main_banner_03.jpg',
];
  late PageController pageController;
  late int selectedCategory;
  late bool isSearching;
  late Genderdatabasehandler genderdatabasehandler;
  late Productdatabasehandler productdatabasehandler;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    pageController=PageController();
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
      productList = await productdatabasehandler.queryProductSearch(searchController.text, "이름순");
    }else{
      if(selectedCategory == 0){//선택된 카테고리에 따라 제품 보여주기
        productList = await productdatabasehandler.queryProduct("이름순");
      }else if(selectedCategory == 1){
        productList = await productdatabasehandler.queryProductCategory('gc_seq', 1, "이름순");
      }else{
        productList = await productdatabasehandler.queryProductCategory('gc_seq', 2, "이름순");
      }
    }

    return (
      genderList: genderList,
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
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: loadPageData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) { //로딩 중
              return Center(child: CircularProgressIndicator());
            }
            List<CategoryGender> makerList = snapshot.data!.genderList; //제조사 리스트
            List<Product> productList = snapshot.data!.productList; //제품 리스트
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amberAccent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '환영합니다.'
                      ),
                    )
                  ),
                ),
                Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
      children: [
        SizedBox(
          height: 260,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return Image.asset(
                bannerImages[index],
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.5),
              );
            },
          ),
        ),
      
        const SizedBox(height: 8),
      
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: pageController,
            count: bannerImages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              expansionFactor: 3,
              activeDotColor: PColor.primaryColor,
              dotColor: Colors.grey.shade400,
            ),
          ),
        ),
      ],
        ),
      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: TextField( //검색창
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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