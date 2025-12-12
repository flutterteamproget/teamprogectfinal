import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> list = ['1','2','3','4','5','6','7',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Column(
          children: [
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
                    color: Colors.grey,
                    child: Text(list[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}