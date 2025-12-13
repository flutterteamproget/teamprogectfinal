import 'package:flutter/material.dart';
import 'package:teamprogectfinal/model/category_color.dart';
import 'package:teamprogectfinal/model/category_gender.dart';
import 'package:teamprogectfinal/model/category_kind.dart';
import 'package:teamprogectfinal/model/category_size.dart';
import 'package:teamprogectfinal/model/maker.dart';
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
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                // 유저 이미지
              ),
              child: Column(
                children: [
                  // 유저 이름
                ],
              )
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: genderList.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(genderList[index].toString()),
                    children: [
                      ListView.builder(
                        itemCount: kindList.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(kindList[index].toString())
                          );
                        }
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  loadUserImage(){
    FutureBuilder(
      future: lHandler.queryUser2('u_image', 1), // u_seq 불러올 방법좀요
      builder: (context, snapshot) {
        return snapshot.hasData && snapshot.data!.isNotEmpty
        ? Image.asset(snapshot.data!)
        : Center(
          child: Text('데이터가 없습니다.'));
      },
    );
  }

  loadUserInfo(String userinfo){
    FutureBuilder(
      future: lHandler.queryUser2(userinfo, 1), // u_seq 불러올 방법좀요
      builder: (context, snapshot) {
        return snapshot.hasData && snapshot.data!.isNotEmpty
        ? Text(snapshot.data!)
        : Center(
          child: Text('데이터가 없습니다.'));
      },
    );
  }

  generateTile(){
  }
}