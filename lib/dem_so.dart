import 'package:flutter/material.dart';

class CountNumber extends StatefulWidget {
  const CountNumber({super.key});

  @override
  State<CountNumber> createState() => _CountNumberState();
}

class _CountNumberState extends State<CountNumber> {
  int numberCount = 0; 
  Color textColor = Colors.black; 

  void _increaseNumber() {
    setState(() {
      numberCount++;
      textColor = Colors.green; 
    });
  }

  void _decreaseNumber() {
    setState(() {
      numberCount--;
      textColor = Colors.red; 
    });
  }

  void _resetNumber() {
    setState(() {
      numberCount = 0;
      textColor = Colors.black; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ứng dụng Đếm số"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Giá trị hiện tại:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$numberCount',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    textStyle:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _decreaseNumber,
                  child: const Text("Giảm"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    textStyle:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _resetNumber,
                  child: const Text("Đặt lại"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    textStyle:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _increaseNumber,
                  child: const Text("Tăng"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
