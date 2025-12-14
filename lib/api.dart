import 'package:dio/dio.dart';
import 'package:flutter_baitap_nhom4/model/product.dart';

class API {
  Future<List<Product>> getAllroduct() async {
    var dio = Dio();
    var url = 'https://fakestoreapi.com/products';

    try {
      var response = await dio.get(url);
      List<Product> ls = [];

      if (response.statusCode == 200) {
        List data = response.data;
        ls = data.map((json) => Product.fromJson(json)).toList();
      }
      return ls;
    } catch (e) {
      print("Lỗi: $e");
      return [];
    }
  }
}
var test_api= API();