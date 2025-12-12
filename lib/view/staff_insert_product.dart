import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamprogectfinal/model/category_size.dart';
import 'package:teamprogectfinal/model/product.dart';
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
  //사이즈
  List<CategorySize> sizeList = [];
  CategorySize? selectedSize;
  late SizeCategoryDatabasehandler sizeHandler;

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
    loadSizes();
  }

  Future loadSizes() async {
    List<CategorySize> temp = await sizeHandler.queryGender();
    setState(() {
      sizeList = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인 페이지')),

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
                        child: TextField(
                          controller: cc_colorcontroller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "컬러",
                          ),
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
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "사이즈",
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value;
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
                          controller: p_makercontroller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "제조사",
                          ),
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
