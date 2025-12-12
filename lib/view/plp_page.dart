import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:teamprogectfinal/util/font_size.dart';

class PlpPage extends StatefulWidget {
  const PlpPage({super.key});

  @override
  State<PlpPage> createState() => _PlpPageState();
}

class _PlpPageState extends State<PlpPage> {
  List<String> list = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19'];
  late int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전체 상품'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      
                    }, 
                    child: Text('제조사1')
                  ),
                  TextButton(
                    onPressed: () {
                      
                    }, 
                    child: Text('제조사2')
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ), 
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(
                            style: TextStyle(
                              fontSize: FontSize.productTitle
                            ),
                            list[index]
                          ),
                          Text(
                            list[index]
                          ),
                          Text(
                            list[index]
                          ),
                          Text(
                            list[index]
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}