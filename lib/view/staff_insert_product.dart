import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamprogectfinal/model/category_color.dart';
import 'package:teamprogectfinal/model/category_gender.dart';
import 'package:teamprogectfinal/model/category_kind.dart';
import 'package:teamprogectfinal/model/category_size.dart';
import 'package:teamprogectfinal/model/maker.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/vm/colordatabasehandler.dart';
import 'package:teamprogectfinal/vm/genderdatabasehandler.dart';
import 'package:teamprogectfinal/vm/kind_category_databasehandler.dart';
import 'package:teamprogectfinal/vm/makerdatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';
import 'package:teamprogectfinal/vm/size_category_databasehandler.dart';

class StaffInsertProduct extends StatefulWidget {
  const StaffInsertProduct({super.key});

  @override
  State<StaffInsertProduct> createState() => _StaffInsertProductState();
}

class _StaffInsertProductState extends State<StaffInsertProduct> {
  late TextEditingController p_namecontroller;
  late Productdatabasehandler handler;
  late TextEditingController p_pricecontroller;
  late TextEditingController cc_colorcontroller;
  late TextEditingController p_sizecontroller;
  late TextEditingController p_makercontroller;
  late TextEditingController p_stockcontroller;
  
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

  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  @override
  void initState() {
    super.initState();
    p_namecontroller = TextEditingController();
    handler = Productdatabasehandler();
    p_pricecontroller = TextEditingController();
    cc_colorcontroller = TextEditingController();
    p_sizecontroller = TextEditingController();
    p_makercontroller = TextEditingController();
    p_stockcontroller = TextEditingController();
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
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey,
                          child: Center(
                            child: imageFile == null
                                ? Icon(Icons.face)
                                : Image.file(File(imageFile!.path)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: ElevatedButton(
                          onPressed: () =>
                              getImageFromGallery(ImageSource.gallery),
                          child: Text("이미지 가져오기"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(220, 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          controller: p_namecontroller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "제품명",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          controller: p_pricecontroller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "가격",
                          ),
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: DropdownButtonFormField<CategoryColor>(
                          initialValue: selectedcolor,
                          items: colorlist.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size.cc_name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              
                            ),
                            labelText: "컬러",
                          ),
                          onChanged: (value) {
                              selectedcolor = value;
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: DropdownButtonFormField<CategorySize>(
                          initialValue: selectedSize,
                          items: sizeList.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size.sc_name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              
                            ),
                            labelText: "사이즈",
                          ),
                          onChanged: (value) {
                              selectedSize = value;
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: DropdownButtonFormField<CategoryGender>(
                          initialValue: selectedgender,
                          items: genderList.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size.gc_name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              
                            ),
                            labelText: "성별",
                          ),
                          onChanged: (value) {
                              selectedgender = value;
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: DropdownButtonFormField<CategoryKind>(
                          initialValue: selectedKind,
                          items:kindList.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size.kc_name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              
                            ),
                            labelText: "신발종류",
                          ),
                          onChanged: (value) {
                              selectedKind = value;
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: DropdownButtonFormField<Maker>(
                          initialValue: selectedmaker,
                          items:makerList.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size.m_name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              
                            ),
                            labelText: "제조사",
                          ),
                          onChanged: (value) {
                              selectedmaker = value;
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          controller: p_stockcontroller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "재고",
                          ),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        insertAction();
                      },
                      child: Text("상품등록"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } //build

  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(
      source: imageSource,
    ); //파일경로
    if (pickedFile == null) {
      return; //취소하면 빠져나감
    } else {
      imageFile = XFile(pickedFile.path); //IOS에도 돌아가고 안드로이드에서도 돌아감
      setState(() {});
    }
  }

  Future insertAction() async {
    //File Type Byte Type으로 변환하기
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    var productInsert = Product(
      p_name: p_namecontroller.text,
      p_price: int.parse(p_pricecontroller.text),
      p_stock: int.parse(p_stockcontroller.text),
      p_image: getImage,
      sc_seq: selectedSize!.sc_seq,
      gc_seq: selectedgender!.gc_seq,
      cc_seq: selectedcolor!.cc_seq,
      m_seq: selectedmaker!.m_seq,
      kc_seq: selectedKind!.kc_seq,


    
     
    );

    int check = await handler.insertProduct(productInsert);
    if (check == 0) {
      //Error
    } else {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
      title: '입력결과',
      middleText: '상품이 등록되었습니다',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
