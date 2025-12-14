import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
     body: SafeArea(//bỏ qua mắt iphone
       child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,//duoi end trên start giữa center, spaceAround tạo khoang cách đều nhau, spaceBetween giữa các phần tử spaceEvenly tạo khoảng cách đều nhau cả 2 đầu
         children: [
           Center(
            child: Text(
              "Hello World",
               style: TextStyle(color: Colors.red, fontSize: 50),
               ),
            ),
            Icon(Icons.heart_broken,color: Colors.red,size: 100,),
            Text("Goodbye World",style: TextStyle(color: Colors.blue, fontSize: 30),)
         ],
       ),
     ),
    );
  }
}