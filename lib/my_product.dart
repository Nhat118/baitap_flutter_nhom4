import 'package:flutter/material.dart';
import 'api.dart'; // Import file chứa class API
import 'package:flutter_baitap_nhom4/model/product.dart';// Import file chứa model Product

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  // Khai báo biến Future để tránh gọi API liên tục khi set state
  late Future<List<Product>> _listProductFuture;
  final API _api = API();

  @override
  void initState() {
    super.initState();
    _listProductFuture = _api.getAllroduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Màu nền nhẹ cho ứng dụng
      appBar: AppBar(
        title: const Text("Cửa Hàng Online", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _listProductFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return productGridView(snapshot.data!);
          } else {
            return const Center(child: Text("Không có sản phẩm nào."));
          }
        },
      ),
    );
  }

  // Widget hiển thị dạng lưới (Grid)
  Widget productGridView(List<Product> ls) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cột
        childAspectRatio: 0.7, // Tỷ lệ chiều rộng/cao của thẻ (cao hơn rộng)
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: ls.length,
      itemBuilder: (context, index) {
        return productItem(ls[index]);
      },
    );
  }

  // Widget hiển thị từng sản phẩm (Card)
  Widget productItem(Product p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Phần hình ảnh
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              child: Image.network(
                p.image,
                fit: BoxFit.contain, // Hiển thị trọn vẹn ảnh sản phẩm
              ),
            ),
          ),
          // 2. Phần thông tin
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên sản phẩm
                Text(
                  p.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Cắt bớt nếu tên quá dài
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                // Hàng chứa Giá và Nút mua
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${p.price}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Đã thêm ${p.title} vào giỏ!'))
                         );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}