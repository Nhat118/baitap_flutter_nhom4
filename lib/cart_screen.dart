// cart_screen.dart
import 'package:flutter/material.dart';
import 'cart_store.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartStore _cartStore = CartStore();

  void _updateCart() {
    setState(() {});
  }

  // Hàm xử lý thanh toán
  void _processPayment() {
    // 1. Hiển thị hộp thoại xác nhận hoặc loading
    showDialog(
      context: context,
      barrierDismissible: false, // Không cho bấm ra ngoài
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // 2. Giả lập delay 2 giây để thanh toán
    Future.delayed(const Duration(seconds: 2), () {
      // Đóng loading
      Navigator.of(context).pop();

      // Xóa giỏ hàng
      _cartStore.clearCart();
      
      // Cập nhật lại giao diện (sẽ hiện giỏ hàng trống)
      _updateCart();

      // Hiển thị thông báo thành công
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Thành công!"),
          content: const Text("Cảm ơn bạn đã mua hàng. Đơn hàng đang được xử lý."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng thông báo
                Navigator.of(context).pop(); // Quay về màn hình danh sách sản phẩm
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ Hàng Của Bạn"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _cartStore.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text("Giỏ hàng đang trống!", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Tiếp tục mua sắm"),
                  )
                ],
              ),
            )
          : Column(
              children: [
                // Danh sách sản phẩm
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartStore.items.length,
                    itemBuilder: (context, index) {
                      final item = _cartStore.items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.network(item.product.image, fit: BoxFit.contain),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text("\$${item.product.price}",
                                        style: const TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  _cartStore.decreaseQty(item.product.id);
                                  _updateCart();
                                },
                              ),
                              Text("${item.quantity}",
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  _cartStore.increaseQty(item.product.id);
                                  _updateCart();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.grey),
                                onPressed: () {
                                  _cartStore.removeFromCart(item.product.id);
                                  _updateCart();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // --- PHẦN THANH TOÁN MỚI ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tổng cộng:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("\$${_cartStore.getTotalPrice().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _processPayment, // Gọi hàm thanh toán
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "THANH TOÁN NGAY",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                // -----------------------------
              ],
            ),
    );
  }
}