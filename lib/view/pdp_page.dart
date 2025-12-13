import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamprogectfinal/util/font_size.dart';

class PdpPage extends StatefulWidget {
  const PdpPage({super.key});

  @override
  State<PdpPage> createState() => _PdpPageState();
}

class _PdpPageState extends State<PdpPage> {




  var value = Get.arguments ?? "__";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}