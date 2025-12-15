import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/model/branch.dart';
import 'package:teamprogectfinal/model/buy.dart';
import 'package:teamprogectfinal/model/category_color.dart';
import 'package:teamprogectfinal/model/category_size.dart';
import 'package:teamprogectfinal/model/product.dart';
import 'package:teamprogectfinal/util/font_size.dart';
import 'package:teamprogectfinal/vm/branchdatabasehandler.dart';
import 'package:teamprogectfinal/vm/buydatabasehandler.dart';
import 'package:teamprogectfinal/vm/colordatabasehandler.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';
import 'package:teamprogectfinal/vm/size_category_databasehandler.dart';

class PdpPage extends StatefulWidget {
  const PdpPage({super.key});

  @override
  State<PdpPage> createState() => _PdpPageState();
}

class _PdpPageState extends State<PdpPage> {
  DateTime today =DateTime.now();
  late int quantity;
  late Buydatabasehandler buyhandler;
  List<CategorySize> sizeList = [];
  CategorySize? selectedSize;
  late SizeCategoryDatabasehandler psizeHandler;

  List<Branch> branchList = [];
  Branch? selectedbranch;
  late Branchdatabasehandler branchhandler;

  List<CategoryColor> colorList = [];
  CategoryColor? selectedcolor;
  late Colordatabasehandler colorhandler;

  @override
  void initState() {
    super.initState();
    psizeHandler=SizeCategoryDatabasehandler();
    branchhandler=Branchdatabasehandler();
    colorhandler=Colordatabasehandler();
    buyhandler=Buydatabasehandler();
    quantity=0;
    loadsize();
    loadbranch();
    loadcolor();
  }
Future loadsize() async {
  List<CategorySize> size =
      await psizeHandler.querySizeByProduct(value[0]);

  sizeList = size;
  setState(() {});
}
Future loadcolor() async {
  List<CategoryColor> loadcolors =
      await colorhandler.queryColorByProduct(value[0]);

  colorList = loadcolors;
  setState(() {});
}


    Future loadbranch() async{
      List<Branch> branch = await branchhandler.queryBranch();
      branchList=branch;
      setState(() {
        
      });
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
              borderRadius: BorderRadiusGeometry.circular(4),
            ),
          ),
        ),
      ),
      appBar: AppBar(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.memory(value[2]),
          ),
          Divider(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  value[0],
                  style: TextStyle(
                    fontSize: FontSize.greylittle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${value[1]}원",
                style: TextStyle(
                  fontSize: FontSize.greylittle,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } //build

  bottomsheetbuy() {
  Get.bottomSheet(
    StatefulBuilder(
      builder: (context, bottomSetState) {
        return Container(
          width: 500,
          height: 600,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("색상 선택"),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<CategoryColor>(
                      initialValue: selectedcolor,
                      items: colorList.map((color) {
                        return DropdownMenuItem(
                          value: color,
                          child: Text(color.cc_name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedcolor = value;
                        bottomSetState(() {});
                      },
                    ),
                  ),

                  Text("사이즈 선택"),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<CategorySize>(
                      initialValue: selectedSize,
                      items: sizeList.map((size) {
                        return DropdownMenuItem(
                          value: size,
                          child: Text(size.sc_name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedSize = value;
                        bottomSetState(() {});
                      },
                    ),
                  ),

                  Text("수령지 선택"),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<Branch>(
                      initialValue: selectedbranch,
                      items: branchList.map((branch) {
                        return DropdownMenuItem(
                          value: branch,
                          child: Text(branch.br_name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedbranch = value;
                        bottomSetState(() {});
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  Divider(),

                  /// 👇 구매 수량 UI
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "구매 수량",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  bottomSetState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                bottomSetState(() {
                                  quantity++;
                                });
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  
                  Text(
                    "총결제 금액  ${value[1] * quantity}원",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 350,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if(quantity==0){
                        Get.snackbar("경고", "수량을 정해주세요");
                        
                      }else{
                      insertAction();
                      Get.back();

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("바로구매"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}


Future insertAction()async{

var buyInsert = Buy(

  u_seq: value[4],
  p_seq: value[3],
  br_seq: selectedbranch!.br_seq,
  b_date: today.toString().substring(0,10),
  b_price: value[1]*quantity,
  b_quantity:quantity,
);

   int check = await buyhandler.insertBuy(buyInsert);
    if (check == 0) {
      //Error
    } else {
      _showDialog();
    }
  

}


_showDialog() {
    Get.defaultDialog(
      title: '구매',
      middleText: '구매가 완료되었습니다',
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