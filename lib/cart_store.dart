// cart_store.dart
import 'package:flutter_baitap_nhom4/model/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartStore {
  static final CartStore _instance = CartStore._internal();
  factory CartStore() => _instance;
  CartStore._internal();

  final List<CartItem> items = [];

  void addToCart(Product p) {
    try {
      CartItem item = items.firstWhere((element) => element.product.id == p.id);
      item.quantity++;
    } catch (e) {
      items.add(CartItem(product: p));
    }
  }

  void removeFromCart(int productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  void increaseQty(int productId) {
    var item = items.firstWhere((element) => element.product.id == productId);
    item.quantity++;
  }

  void decreaseQty(int productId) {
    var item = items.firstWhere((element) => element.product.id == productId);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }
  }

  void clearCart() {
    items.clear();
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in items) {
      num price = item.product.price is num ? item.product.price : 0;
      total += price * item.quantity;
    }
    return total;
  }
  
  // --- MỚI: Tính tổng số lượng sản phẩm (Ví dụ: 2 áo + 1 quần = 3) ---
  int get totalQuantity {
    int count = 0;
    for (var item in items) {
      count += item.quantity;
    }
    return count;
  }
}