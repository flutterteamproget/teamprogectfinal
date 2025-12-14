import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/view/main_page.dart';
import 'package:teamprogectfinal/view/signup.dart';
import 'package:teamprogectfinal/vm/userdatabasehandler.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController idcontroller;
  late TextEditingController pwcontroller;
  late Logindatabasehandler  handler;

  @override
  void initState() {
    super.initState();
  idcontroller=TextEditingController();
  pwcontroller=TextEditingController();
  handler =Logindatabasehandler();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "아이디",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: idcontroller,
                          decoration: InputDecoration(
                             enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            ),
                            hintText: "아이디를 입력하세요",
                            hintStyle: TextStyle(
                              fontSize: 14
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 13)
                          ),
                          
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "비밀번호",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: pwcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            ),
                            hintText: "비밀번호를 입력하세요",
                            hintStyle: TextStyle(
                              fontSize: 14
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 13)
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      
                      onPressed: () {
                        logincheck();
                      },
                      child: Text("로그인"),
                      style: ElevatedButton.styleFrom(
                       
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: Size(300, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Get.to(Signup()),
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
            
            ),
            ],
          ),
        ),
      ),
    );
  }//build

  logincheck() async{
  
 int count=await handler.queryLogincheck(
  idcontroller.text,
   pwcontroller.text
   );

  if(idcontroller.text.trim().isEmpty||pwcontroller.text.isEmpty){
    Get.snackbar("로그인실패", "아이디 또는 비밀번호를 입력해주세요",
    backgroundColor: Colors.red,

    );
  }else if(count==0){
   Get.snackbar("로그인실패", "아이디 또는 비밀번호가 틀립니다",
    backgroundColor: Colors.red,

    );
  }else{
     Get.snackbar("로그인성공", "환영합니다",);
     Get.to(MainPage());
  }

      

  }
}//class