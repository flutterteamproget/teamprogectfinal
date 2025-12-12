import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/view/staff_mainpage.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({super.key});

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  late TextEditingController idcontroller;
  late TextEditingController pwcontroller;

  @override
  void initState() {
    super.initState();
  idcontroller=TextEditingController();
  pwcontroller=TextEditingController();
 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            width: 350,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("사원번호",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    controller: idcontroller,
                    decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                       
                        borderSide: BorderSide(
                          
                          color: Colors.black
                        )
                      ),
                      labelText: "사원번호",
                    ),
                    
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Password"),
                ),
                SizedBox(
                  width: 220,
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
                      labelText: "PW",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    
                    onPressed: () {
                      // logincheck();\
                      Get.to(StaffMainpage());
                    },
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                     
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(220, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4)
                      )
                    ),
                    ),
                ),
               
              ],
            ),
          
          ),
          ],
        ),
      ),
    );
  }
}