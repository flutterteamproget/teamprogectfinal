import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamprogectfinal/model/user.dart';
import 'package:teamprogectfinal/util/color.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';

class MyUpdate extends StatefulWidget {
  const MyUpdate({super.key});

  @override
  State<MyUpdate> createState() => _MyUpdateState();
}

class _MyUpdateState extends State<MyUpdate> {
  late Logindatabasehandler handler;
  late TextEditingController namecontroller;
  late TextEditingController idcontroller;
  late TextEditingController pwccontroller;
  late TextEditingController pwcheckcontroller;
  late TextEditingController phonecontroller;

  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  late int firstDisp; // 이미지 수정했는지 확인

  var value = Get.arguments ?? '___';

  @override
  void initState() {
    super.initState();
    handler = Logindatabasehandler();
    namecontroller = TextEditingController();
    idcontroller = TextEditingController();
    pwccontroller = TextEditingController();
    pwcheckcontroller = TextEditingController();
    phonecontroller = TextEditingController();

    firstDisp = 0;

    namecontroller.text = value[1];
    idcontroller.text = value[2];
    phonecontroller.text = value[3];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: PColor.baseBackgroundColor,
        appBar: AppBar(backgroundColor: PColor.appBarBackgroundColor),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                firstDisp == 0
                ? Padding( // 이미지를 수정하지 않았을 때
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey,
                    child: Image.memory(value[4])
                  ) 
                )
                : Padding( // 이미지를 수정했을 때
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey,
                    child: Center(
                      child: imageFile == null
                      ? Icon(Icons.face)
                      : Image.file(File(imageFile!.path)),
                    ),
                  ) 
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: ElevatedButton(
                    onPressed: () => getImageFromGallery(ImageSource.gallery),
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
                      controller: namecontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "이름",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: idcontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "아이디",
                        filled: true,
                        fillColor: PColor.borderColor,
                      ),
                      enabled: false, // 수정 불가 효과 적용
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: pwccontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "비밀번호",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: pwcheckcontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "비밀번호 확인",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "전화번호",
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (namecontroller.text.trim().isEmpty ||
                        idcontroller.text.trim().isEmpty ||
                        pwccontroller.text.trim().isEmpty ||
                        pwcheckcontroller.text.trim().isEmpty ||
                        phonecontroller.text.trim().isEmpty) {
                      Get.snackbar(
                        "수정 실패",
                        "빈칸을 전부 채워주세요.",
                        backgroundColor: Colors.red,
                      );
                    } else if (pwccontroller.text.trim() !=
                        pwcheckcontroller.text.trim()) {
                      Get.snackbar(
                        "수정 실패",
                        "비밀번호가 일치하지 않습니다. 다시 입력해주세요.",
                        backgroundColor: Colors.red,
                      );
                    } else if (firstDisp==0) {
                     updateAction();
                    } else{
                      updateActionAll();
                    }
                  },
                  child: Text("수정"),
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
      firstDisp += 1; // 이미지 선택하면 firstDisp 1 증가
      setState(() {});
    }
  }

  Future updateActionAll() async {
    //File Type을 Byte Type으로 변환하기
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    var userUpdate = User(
      u_seq: value[0],
      u_name: namecontroller.text,
      u_id: idcontroller.text,
      u_password: pwccontroller.text,
      u_phone: phonecontroller.text,
      u_image: getImage,
    );

    int check = await handler.updateUserAll(userUpdate);
    if (check == 0) {
      //Error
    } else {
      _showDialog();
    }
  }
  Future updateAction() async {
    var userUpdate = User(
      u_seq: value[0],
      u_name: namecontroller.text,
      u_id: idcontroller.text,
      u_password: pwccontroller.text,
      u_phone: phonecontroller.text,
      u_image: value[4],
    );

    int check = await handler.updateUser(userUpdate);
    if (check == 0) {
      //Error
    } else {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
      title: '수정 결과',
      middleText: '수정이 완료되었습니다.',
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