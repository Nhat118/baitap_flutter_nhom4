import 'package:flutter/material.dart';
import 'api.dart';
import 'package:flutter_baitap_nhom4/model/product.dart';
import 'cart_store.dart';
import 'cart_screen.dart';
import 'product_detail.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  final API _api = API();
  List<Product> _allProducts = [];
  List<Product> _displayProducts = [];
  bool _isLoading = true;
  String _errorMessage = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Khi quay lại từ màn hình khác, cập nhật lại số lượng giỏ hàng
  void _refreshCart() {
    setState(() {});
  }

  void _loadData() async {
    try {
      var data = await _api.getAllroduct();
      setState(() {
        _allProducts = data;
        _displayProducts = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _runFilter(String keyword) {
    List<Product> results = [];
    if (keyword.isEmpty) {
      results = _allProducts;
    } else {
      results = _allProducts
          .where((p) => p.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _displayProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy số lượng từ store
    int cartCount = CartStore().totalQuantity;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Cửa Hàng Online", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // --- PHẦN ICON GIỎ HÀNG CÓ SỐ (BADGE) ---
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 5),
            child: InkWell(
              onTap: () {
                // Khi quay về từ giỏ hàng thì update lại số (phòng trường hợp xóa hàng)
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()))
                    .then((_) => _refreshCart());
              },
              child: Stack(
                clipBehavior: Clip.none, // Cho phép số hiển thị tràn ra ngoài icon
                children: [
                  const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 28),
                  
                  // Chỉ hiện badge nếu số lượng > 0
                  if (cartCount > 0)
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
          // ----------------------------------------
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Tìm kiếm sản phẩm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(child: Text("Lỗi: $_errorMessage"))
                    : _displayProducts.isEmpty
                        ? const Center(child: Text("Không tìm thấy sản phẩm nào."))
                        : productGridView(_displayProducts),
          ),
        ],
      ),
    );
  }

  Widget productGridView(List<Product> ls) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: ls.length,
      itemBuilder: (context, index) {
        return productItem(ls[index]);
      },
    );
  }

  Widget productItem(Product p) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: p)))
            .then((_) => _refreshCart()); // Quay về từ chi tiết cũng update
      },
      child: Container(
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: Image.network(p.image, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${p.price}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      
                      // Nút thêm vào giỏ
                      InkWell(
                        onTap: () {
                          CartStore().addToCart(p);
                          
                          // --- QUAN TRỌNG: Gọi setState để cập nhật số trên icon ngay lập tức ---
                          setState(() {}); 
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã thêm ${p.title} vào giỏ!'), duration: const Duration(milliseconds: 500))
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(8)),
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
      ),
    );
  }
}