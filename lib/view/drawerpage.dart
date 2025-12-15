import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/category_color.dart';
import 'package:teamprogectfinal/model/category_gender.dart';
import 'package:teamprogectfinal/model/category_kind.dart';
import 'package:teamprogectfinal/model/category_size.dart';
import 'package:teamprogectfinal/model/maker.dart';
import 'package:teamprogectfinal/view/my_page.dart';
import 'package:teamprogectfinal/view/plp_drawer_page.dart';
import 'package:teamprogectfinal/vm/colordatabasehandler.dart';
import 'package:teamprogectfinal/vm/genderdatabasehandler.dart';
import 'package:teamprogectfinal/vm/kind_category_databasehandler.dart';
import 'package:teamprogectfinal/vm/makerdatabasehandler.dart';
import 'package:teamprogectfinal/vm/size_category_databasehandler.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  late Logindatabasehandler lHandler;
  late Genderdatabasehandler gHandler;


  //성별
  List<CategoryGender> genderList=[];
  CategoryGender? selectedgender;
  late Genderdatabasehandler genderHandler;

  //사이즈
  List<CategorySize> sizeList = [];
  CategorySize? selectedSize;
  late SizeCategoryDatabasehandler sizeHandler;

  //신발종류
  List<CategoryKind> kindList=[];
  CategoryKind? selectedKind;
  late KindCategoryDatabasehandler kindHandler;

  //컬러
  List<CategoryColor> colorlist=[];
  CategoryColor? selectedcolor;
  late Colordatabasehandler colorhandler;

  //제조사
  List<Maker> makerList=[];
  Maker? selectedmaker;
  late Makerdatabasehandler makerhandler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lHandler = Logindatabasehandler();
    sizeHandler = SizeCategoryDatabasehandler();
    genderHandler =Genderdatabasehandler();
    kindHandler =KindCategoryDatabasehandler();
    colorhandler =Colordatabasehandler();
    makerhandler=Makerdatabasehandler();
    loadSizes();
    loadgender();
    loadkind();
    loadcolor();
    loadmaker();
  }
    //성별
  Future loadgender()async{
    List<CategoryGender> result = await genderHandler.queryGender();
    genderList=result;
    setState(() {
      
    });
  }

    //사이즈
  Future loadSizes() async {
    List<CategorySize> temp = await sizeHandler.querySize();
   
    sizeList = temp;
    setState(() {
      
    });
  }

  //신발종류
  Future loadkind() async{
    List<CategoryKind> kind = await kindHandler.queryKind();
      kindList=kind;
      setState(() {
      });
  }

 Future loadcolor()async{
    List<CategoryColor> color= await colorhandler.queryColor();
    colorlist=color;
    setState(() { });
  }

  Future loadmaker() async{
    List<Maker> maker = await makerhandler.queryMaker();
    makerList=maker;
    
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: ListView(
            children: [
              DrawerHeader(
                child: FutureBuilder(
                  future: lHandler.queryUser2(1), // 1은 추후 u_seq로 수정 예정
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(MyPage()),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(snapshot.data!['u_image'] as Uint8List)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${snapshot.data!['u_name']} 고객님'),
                      ],
                    )
                    : Text('불러올 데이터가 없습니다.');
                  },
                )
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: genderList.length,
                  itemBuilder: (context, index1) {
                    return ExpansionTile(
                      title: Text(genderList[index1].gc_name),
                      children: [
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: kindList.length,
                            itemBuilder: (context, index2){
                              return ListTile(
                                title: Text(kindList[index2].kc_name),
                                onTap: () {
                                  Get.to(
                                    PlpDrawerPage(),
                                    arguments: [
                                      ["gc_seq", genderList[index1].gc_seq], 
                                      ["kc_seq", kindList[index2].kc_seq], 
                                      ["${genderList[index1].gc_name} > ${kindList[index2].kc_name}"]
                                    ]
                                  );
                                },
                              );
                            }
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              ExpansionTile(
                title: Text('All Brand'),
                children: [
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      itemCount: makerList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(
                            makerList[index].m_name
                          ),
                          onTap: () {
                            Get.to(
                              PlpDrawerPage(),
                              arguments: [
                                ["m_seq", makerList[index].m_seq],
                                [makerList[index].m_name]
                              ]
                            );
                          },
                        );
                      }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}