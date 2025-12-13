import 'package:flutter/material.dart';
import 'package:teamprogectfinal/vm/productdatabasehandler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Productdatabasehandler phandler;

  @override
  void initState() {
    super.initState();
    phandler = Productdatabasehandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded( 
            child: FutureBuilder(
              future: phandler.queryProduct(),
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data!.isNotEmpty
                    ? GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.grey,
                            child: Column(
                              children: [
                                Image.memory(snapshot.data![index].p_image)
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("등록된 상품이 없습니다"),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
