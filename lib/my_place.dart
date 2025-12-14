import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [block1(), block2(), block3(), block4()]),
    );
  }

  Widget block1() {
    var src =
        "https://images.unsplash.com/photo-1664333039578-28ad613ee536?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
    return Image.network(src);
  }

  Widget block2() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [block2_1(), block2_2()],
      ),
    );
  }

  Widget block2_1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Đại Nội Huế", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Thành Phố Huế, Việt Nam", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget block2_2() {
    return Row(
      children: const [
        Icon(Icons.star, color: Colors.red),
        Text("1056"),
      ],
    );
  }

  Widget block3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [block3_1(), block3_2(), block3_3()],
    );
  }

  Widget block3_1() {
    return Column(
      children: const [
        Icon(Icons.call, color: Colors.blue),
        Text("CALL", style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget block3_2() {
    return Column(
      children: const [
        Icon(Icons.near_me, color: Colors.blue),
        Text("ROUTE", style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget block3_3() {
    return Column(
      children: const [
        Icon(Icons.share, color: Colors.blue),
        Text("SHARE", style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget block4() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "Đại Nội Huế là quần thể di tích lịch sử văn hóa đặc sắc, nằm ở trung tâm thành phố Huế, tỉnh Thừa Thiên Huế, Việt Nam. Được xây dựng vào đầu thế kỷ 19 dưới triều đại nhà Nguyễn, Đại Nội Huế từng là kinh đô của Việt Nam và là nơi ở của các vua chúa cùng hoàng tộc. Quần thể này bao gồm nhiều công trình kiến trúc độc đáo như Cung Diên Thọ, Cung Trường Sanh, Điện Thái Hòa và nhiều đền đài, lăng tẩm khác. Đại Nội Huế không chỉ là biểu tượng của quyền lực và sự thịnh vượng trong lịch sử Việt Nam mà còn là di sản văn hóa thế giới được UNESCO công nhận. Ngày nay, Đại Nội Huế thu hút hàng ngàn du khách trong và ngoài nước đến tham quan, tìm hiểu về lịch sử và văn hóa phong phú của Việt Nam."),
    );
  }
}
