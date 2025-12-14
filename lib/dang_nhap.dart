import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Profile.dart';

class LoginAPI extends StatefulWidget {
  LoginAPI({super.key});

  @override
  State<LoginAPI> createState() => _LoginAPIState();
}

class _LoginAPIState extends State<LoginAPI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isHidden = true;

  String successMessage = "";
  String errorMessage = "";

  // Controller để lấy dữ liệu nhập
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // Hàm gọi API
  Future<void> login() async {
  setState(() {
    successMessage = "";
    errorMessage = "";
  });

  final url = Uri.parse("https://dummyjson.com/auth/login");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": _usernameCtrl.text.trim(),
      "password": _passwordCtrl.text.trim()
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(userData: data),
      ),
    );
  } else {
    final error = jsonDecode(response.body);
    setState(() {
      errorMessage = error["message"] ?? "Đăng nhập thất bại";
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Form Đăng nhập",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),

      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Tên người dùng
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Tên người dùng',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên người dùng';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Mật khẩu
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải ≥ 6 ký tự';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // NÚT ĐĂNG NHẬP
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();   // Gọi API
                    }
                  },
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 15),

                // THÔNG BÁO
                if (successMessage.isNotEmpty)
                  Text(
                    successMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
