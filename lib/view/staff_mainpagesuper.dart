import 'package:flutter/material.dart';

class StaffMainpagesuper extends StatefulWidget {
  const StaffMainpagesuper({super.key});

  @override
  State<StaffMainpagesuper> createState() => _StaffMainpagesuperState();
}

class _StaffMainpagesuperState extends State<StaffMainpagesuper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
               child: ElevatedButton(
                      onPressed: () {},
                      child: Text("판매 및 매출 현황"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 350),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4),
                        ),
                      ),
                    ),
             ),
             Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
               child: ElevatedButton(
                      onPressed: () {},
                      child: Text("결제 승인"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 350),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4),
                        ),
                      ),
                    ),
             ),
            
          ],
        ),
      ),
    );
  }
}