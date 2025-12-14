import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BMI(),
  ));
}

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  // --- PHẦN BỔ SUNG: Khai báo biến và Controller ---
  final _formKey = GlobalKey<FormState>();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  
  double? _bmi;
  String _classification = '';

  // Hàm giải phóng bộ nhớ khi thoát màn hình
  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  // --- PHẦN BỔ SUNG: Logic tính toán ---
  void _calculate() {
    // Ẩn bàn phím khi ấn nút
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final h = double.parse(_heightCtrl.text);
      final w = double.parse(_weightCtrl.text);

      setState(() {
        // Công thức BMI = Cân nặng / (Chiều cao * Chiều cao)
        _bmi = w / (h * h);

        // Logic phân loại theo chuẩn WHO
        if (_bmi! < 18.5) {
          _classification = 'Thiếu cân';
        } else if (_bmi! < 25) {
          _classification = 'Bình thường';
        } else if (_bmi! < 30) {
          _classification = 'Thừa cân';
        } else {
          _classification = 'Béo phì';
        }
      });
    }
  }

  // Hàm lấy giá trị text hiển thị (làm tròn 2 chữ số thập phân)
  String _bmiText() {
    return _bmi?.toStringAsFixed(2) ?? '';
  }

  // Hàm chọn màu dựa trên kết quả
  Color _colorForClass(String type) {
    switch (type) {
      case 'Thiếu cân':
        return Colors.blue;
      case 'Bình thường':
        return Colors.green;
      case 'Thừa cân':
        return Colors.orange;
      case 'Béo phì':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white, // Thêm màu chữ trắng cho đẹp
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView( // Thêm scroll để tránh lỗi tràn màn hình khi bàn phím hiện
          child: Padding( // Thêm padding tổng thể
            padding: const EdgeInsets.all(16.0),
            child: Form( // Đổi từ Center key thành Form key
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Khung giống mẫu: card nhỏ
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Chiều cao
                        TextFormField(
                          controller: _heightCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Chiều cao (m)',
                            hintText: 'Ví dụ: 1.75', // Thêm hint text
                            prefixIcon: const Icon(Icons.height),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Vui lòng nhập chiều cao';
                            }
                            final parsed = double.tryParse(v);
                            if (parsed == null) return 'Chiều cao không hợp lệ';
                            if (parsed <= 0) return 'Chiều cao phải > 0';
                            if (parsed > 3) return 'Chiều cao không thực tế'; // Thêm logic chặn
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
          
                        // Cân nặng
                        TextFormField(
                          controller: _weightCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Cân nặng (kg)',
                             hintText: 'Ví dụ: 65',
                            prefixIcon: const Icon(Icons.monitor_weight),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Vui lòng nhập cân nặng';
                            }
                            final parsed = double.tryParse(v);
                            if (parsed == null) return 'Cân nặng không hợp lệ';
                            if (parsed <= 0) return 'Cân nặng phải > 0';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
          
                        // Nút tính BMI
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.calculate, color: Colors.white),
                            label: const Text('Tính BMI', style: TextStyle(color: Colors.white, fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: _calculate,
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  const SizedBox(height: 22),
          
                  // Kết quả BMI và phân loại
                  if (_bmi != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Chỉ số BMI: ${_bmiText()}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: _colorForClass(_classification),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Phân loại: $_classification',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: _colorForClass(_classification),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}