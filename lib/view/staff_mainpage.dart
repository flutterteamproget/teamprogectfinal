import 'package:flutter/material.dart';

class StaffMainpage extends StatefulWidget {
  const StaffMainpage({super.key});

  @override
  State<StaffMainpage> createState() => _StaffMainpageState();
}

class _StaffMainpageState extends State<StaffMainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ElevatedButton(
                  
                      onPressed: () {
                        
                      },
                      child: Text("상품등록"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 180),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                      ),
                      
                      
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: ElevatedButton(
                  
                      onPressed: () {
                        
                      },
                      child: Text("배너등록"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 180),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                      ),
                      
                      
                      ),
              ),
              Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: ElevatedButton(
                  
                      onPressed: () {
                        
                      },
                      child: Text("상품재고"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 180),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                      ),
                      
                      
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: ElevatedButton(
                  
                      onPressed: () {
                        
                      },
                      child: Text("판매 및 매출 현황"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 180),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                      ),
                      
                      
                      ),
              ),
                    
            ],
          ),
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                 child: ElevatedButton(
                      
                          onPressed: () {
                            
                          },
                          child: Text("구매조회"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(180, 180),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(4)
                            ),
                          ),
                          
                          
                          ),
               ),
                         Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                           child: ElevatedButton(
                                           
                                               onPressed: () {
                                                 
                                               },
                                               child: Text("주문조회"),
                                               style: ElevatedButton.styleFrom(
                                                 minimumSize: Size(180, 180),
                                                 backgroundColor: Colors.black,
                                                 foregroundColor: Colors.white,
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadiusGeometry.circular(4)
                                                 ),
                                               ),
                                               
                                               
                                               ),
                         ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                       child: ElevatedButton(
                                       
                                           onPressed: () {
                        
                                           },
                                           child: Text("수주조회"),
                                           style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 180),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                                           ),
                                           
                                           
                                           ),
                     ),
                     Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                       child: ElevatedButton(
                                       
                                           onPressed: () {
                        
                                           },
                                           child: Text("결재 요청"),
                                           style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 180),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4)
                        ),
                                           ),
                                           
                                           
                                           ),
                     ),
             ],
           ),
        ],
      ),
     ),
    );
  }
}