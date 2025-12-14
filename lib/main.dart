import 'package:flutter/material.dart';
import 'package:flutter_baitap_nhom4/NgoQuyLongNhat.dart';
// import 'package:flutter_baitap_nhom4/form_dangnhap.dart';
// import 'package:flutter_baitap_nhom4/dang_nhap.dart';
// import 'my_class.dart';
// import 'my_place.dart';
// import 'my_home_page.dart';
// import 'doi_mau.dart';
// import 'guide_to_layout.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      home: Ngoquylongnhat(), 
    );
  }
}