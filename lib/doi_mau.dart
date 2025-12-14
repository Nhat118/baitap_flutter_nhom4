import 'dart:math';
import 'package:flutter/material.dart';

class ColorChanger extends StatefulWidget {
  const ColorChanger({super.key});

  @override
  State<ColorChanger> createState() => _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> {
  // Biến màu nền
  Color bgColor = Colors.purple;
  String textcolor = "Tím";

  // Danh sách màu
  final List<Color> listColors = [
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.brown,
    Colors.grey
  ];

  // Tên màu tương ứng
  final List<String> listColorNames = [
    "Tím",
    "Xanh lá",
    "Xanh dương",
    "Vàng",
    "Cam",
    "Đỏ",
    "Hồng",
    "Nâu",
    "Xám"
  ];

  // Hàm đổi màu
  void _changeColor() {
    final rand = Random();
    final numberRandom = rand.nextInt(listColors.length);
    setState(() {
      bgColor = listColors[numberRandom];
      textcolor = listColorNames[numberRandom];
    });
  }

  // Hàm đặt lại (đặt cả tên màu)
  void _resetColor() {
    setState(() {
      bgColor = Colors.purple;
      textcolor = "Tím";
    });
  }

  @override
  Widget build(BuildContext context) {
    // Chọn màu chữ/nút tương phản để luôn thấy rõ trên nền hiện tại
    final bool isLight = bgColor.computeLuminance() > 0.5;
    final Color foreground = isLight ? Colors.black : Colors.white;
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: foreground,
      backgroundColor: isLight ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.2),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ứng dụng đổi màu nền"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      // Dùng scaffold background cho phủ toàn màn
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Màu hiện tại:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textcolor,
              style: TextStyle(fontSize: 20, color: foreground),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _changeColor,
                  child: const Text("Đổi màu"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _resetColor,
                  child: const Text("Đặt lại"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
