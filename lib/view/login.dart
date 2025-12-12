import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/model/user.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   late TextEditingController p_namecontroller;
  late Logindatabasehandler handler;
  late TextEditingController p_pricecontroller;
  late TextEditingController p_colorcontroller;
  late TextEditingController p_sizecontroller;
  late TextEditingController p_makercontroller;

  late TextEditingController p_quintycontroller;
final ImagePicker picker =ImagePicker();
  XFile? imageFile;
  @override
  void initState() {
    super.initState();
    p_namecontroller =TextEditingController();
    handler=Logindatabasehandler();
    p_pricecontroller=TextEditingController();
    p_colorcontroller=TextEditingController();
    p_sizecontroller=TextEditingController();
    p_makercontroller=TextEditingController();
    p_quintycontroller=TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지'),
      ),

       body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.grey,
                  child: Center(
                    child: imageFile ==null
                    ?Icon(Icons.face)
                    :Image.file(File(imageFile!.path)),
                    
                  ),
                
                ),
              ),
              Padding(
               padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ElevatedButton(
                  onPressed: () =>  getImageFromGallery(ImageSource.gallery),
                  child: Text("이미지 가져오기"),
                  style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(220, 40),
            ),
                  
                  ),
              ),
          
                Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:p_namecontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "제품명"
                      ),
                    ),
                  ),
                ),
                Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      
                      controller:p_pricecontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "가격"
                      ),
                    ),
                  ),
                ),
                Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      
                      controller:p_colorcontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "컬러"
                      ),
                    ),
                  ),
                ),
                Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:p_sizecontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "사이즈"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:p_makercontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "제조사"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller:p_quintycontroller ,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                                  ),
                        labelText: "재고"
                      ),
                    ),
                  ),
                ),
          
                ElevatedButton(
                  onPressed: () {
                    // insertAction();
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
        ),
      ),
    );
  }//build
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

// Future insertAction() async {
//     //File Type Byte Type으로 변환하기
//     File imageFile1 = File(imageFile!.path);
//     Uint8List getImage = await imageFile1.readAsBytes();

//     var productInsert = Product(
//       p_name: p_namecontroller.text,
//       p_price: p_pricecontroller.text,
//       p_stock: p_quintycontroller.text,
//       p_image: getImage,
//     );

//     int check = await handler.insertUser(productInsert);
//     if (check == 0) {
//       //Error
//     } else {
//       _showDialog();
//     }
//   }

 _showDialog() {
    Get.defaultDialog(
      title: '입력결과',
      middleText: '회원가입이 완료되었습니다',
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

}//class