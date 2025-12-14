import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _commentController = TextEditingController();

  int _selectedRating = 4; // mặc định giống UI hình

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3EC), // màu nền giống hình
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6A3D),
        title: const Text(
          "Gửi phản hồi",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // -------------------- HỌ TÊN --------------------
              const Text("Họ tên"),
              const SizedBox(height: 4),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: "Họ tên",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập họ tên" : null,
              ),

              const SizedBox(height: 16),

              // -------------------- ĐÁNH GIÁ --------------------
              const Text("Đánh giá (1 - 5 sao)"),
              const SizedBox(height: 4),
              DropdownButtonFormField<int>(
                value: _selectedRating,
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text("${index + 1} sao"),
                  ),
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.star),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) => setState(() {
                  _selectedRating = value!;
                }),
              ),

              const SizedBox(height: 16),

              // -------------------- NỘI DUNG GÓP Ý --------------------
              const Text("Nội dung góp ý"),
              const SizedBox(height: 4),
              TextFormField(
                controller: _commentController,
                maxLines: 5,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.chat_bubble_outline),
                  hintText: "Nội dung góp ý",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập nội dung" : null,
              ),

              const SizedBox(height: 18),

              // -------------------- NÚT GỬI --------------------
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6A3D),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text(
                    "Gửi phản hồi",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gửi thành công!")),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
