import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Khi logout → quay lại trang Login
              Navigator.pop(context);
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // AVATAR
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  userData["image"] ??
                      "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // HỌ TÊN
            infoRow("Họ và tên",
                "${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}"),

            const SizedBox(height: 12),

            // USERNAME
            infoRow("Username", userData['username'] ?? "Không có"),

            const SizedBox(height: 12),

            // EMAIL
            infoRow("Email", userData['email'] ?? "Không có"),

            const SizedBox(height: 12),

            // GIỚI TÍNH
            infoRow("Giới tính", userData['gender'] ?? "Không có"),

            const SizedBox(height: 40),

            // NÚT ĐĂNG XUẤT TO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Đăng xuất",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }
}
