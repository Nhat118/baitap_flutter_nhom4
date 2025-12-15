// product_detail.dart
import 'package:flutter/material.dart';
import 'package:flutter_baitap_nhom4/model/product.dart';
import 'cart_store.dart'; // Import store để thêm vào giỏ

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh lớn
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Giá và Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${product.price}", 
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent)
                      ),
                      Chip(label: Text(product.category), backgroundColor: Colors.blue.shade50),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text("Mô tả sản phẩm:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(product.description, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5)),
                ],
              ),
            )
          ],
        ),
      ),
      // Nút thêm vào giỏ ở dưới cùng
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton.icon(
          onPressed: () {
            CartStore().addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã thêm vào giỏ hàng!'))
            );
          },
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text("Thêm vào giỏ hàng"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}