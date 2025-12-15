import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _repassCtrl = TextEditingController();

  bool _hidePass1 = true;
  bool _hidePass2 = true;

  String successMessage = "";

  final RegExp emailReg =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _repassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Form Đăng ký", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            // 1. TẮT chế độ tự kiểm tra của cả form (để các ô khác không bị đỏ lòm khi đang gõ)
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Họ tên
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Họ tên',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZÀ-ỹĐđ\s]")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return "Vui lòng nhập họ tên";
                    if (v.trim().length < 2) return "Họ tên quá ngắn";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-+]')),
                    LengthLimitingTextInputFormatter(100),
                  ],
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Vui lòng nhập email";
                    if (!emailReg.hasMatch(v)) return "Email không hợp lệ";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Mật khẩu
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _hidePass1,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                  ],
                  // 2. Khi sửa mật khẩu gốc, báo cho giao diện biết để ô nhập lại tự check lại
                  onChanged: (value) {
                    if (_repassCtrl.text.isNotEmpty) {
                       setState(() {}); 
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_hidePass1 ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _hidePass1 = !_hidePass1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Vui lòng nhập mật khẩu";
                    if (v.length < 6) return "Mật khẩu phải ≥ 6 ký tự";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Nhập lại mật khẩu
                TextFormField(
                  controller: _repassCtrl,
                  obscureText: _hidePass2,
                  keyboardType: TextInputType.visiblePassword,
                  
                  // 3. CHỈ BẬT kiểm tra tự động ở riêng ô này
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    prefixIcon: const Icon(Icons.lock_reset),
                    suffixIcon: IconButton(
                      icon: Icon(_hidePass2 ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _hidePass2 = !_hidePass2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) {
                    // Logic kiểm tra
                    if (v == null || v.isEmpty) return "Vui lòng nhập lại mật khẩu";
                    if (v != _passCtrl.text) return "Mật khẩu không trùng khớp";
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Nút đăng ký
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Khi ấn nút mới kiểm tra toàn bộ (Họ tên, Email...)
                    final valid = _formKey.currentState?.validate() ?? false;
                    setState(() {
                      successMessage = valid ? "Đăng ký thành công!" : "";
                    });
                  },
                  child: const Text(
                    "Đăng ký",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 12),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}