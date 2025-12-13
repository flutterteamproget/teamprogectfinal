import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/util/font_size.dart';

class PdpPage extends StatefulWidget {
  const PdpPage({super.key});

  @override
  State<PdpPage> createState() => _PdpPageState();
}

class _PdpPageState extends State<PdpPage> {
late TextEditingController  sizecontroller;
late TextEditingController branchcontroller;


@override
  void initState() {
    super.initState();
  sizecontroller=TextEditingController();
  branchcontroller=TextEditingController();
  }


  var value = Get.arguments ?? "__";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: ElevatedButton(
            onPressed: () {
              bottomsheetbuy();
            },
            child: Text("구매하기"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
               minimumSize: Size(220, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4)
                      ),

            ),
            ),
            ),
      appBar: AppBar(),



      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
           width:  MediaQuery.of(context).size.width,
            child: Image.memory(value[2])),
            Divider(),

            Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(value[0],
                  style: TextStyle(
                     fontSize: FontSize.greylittle,
                     fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                Text("${value[1]}원",
                style: TextStyle(
                   fontSize: FontSize.greylittle,
                   fontWeight: FontWeight.bold
                ),)

              ],
            )


        ],
      ),



    );



  }//build

  bottomsheetbuy(){
    Get.bottomSheet(
      Container(
        width: 500,
        height: 600,
        color: Colors.white,
        child: Column(
          children: [
           Text("사이즈 선택"),
           SizedBox(
            width: 350,
             child: TextField(
              controller: sizecontroller,
             decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                                      ),
                            labelText: "사이즈 선택"
                          ),
             ),
           ),
           Text("수령지 선택"),
           SizedBox(
            width: 350,
             child: TextField(
              controller: branchcontroller,
             decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                                      ),
                            labelText: "수령지선택"
                          ),
             ),

             
           ),
          Text("총결제 금액                   원")
           
          ],
        ),
      )

    );
  }

}//class