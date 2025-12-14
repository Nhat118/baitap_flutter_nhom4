import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // KHẮC PHỤC 1: Khai báo biến (nếu muốn dùng biến)
  String assignmentName = "Thông Tin Sinh Viên"; 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60, 
                    backgroundImage: AssetImage('assets/images/avt.jpg'),
                    backgroundColor: Colors.transparent, // Màu nền dự phòng nếu ảnh lỗi
                  ),
                  
                  const SizedBox(height: 10),
                  Text(
                    "Ngô Quý Long Nhật", 
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  // _buildRowInfo("Họ và Tên:", "Ngô Quý Long Nhật"),
                  _buildRowInfo("Học Phần:", "Lập trình ứng dụng cho các thiết bị di động"),
                  _buildRowInfo("Mã Sinh Viên:", "22T1020284"),
                  _buildRowInfo("Nhóm:", "Nhóm 4"),
                  _buildRowInfo("Giảng Viên:", "ThS. Nguyễn Dũng"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),


        ],
      ),
    );
  }

  Widget _buildRowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trên (để nếu xuống dòng thì chữ label vẫn nằm trên cùng)
        children: [
          // Phần Label (bên trái)
          Text(
            label, 
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
          ),
          
          const SizedBox(width: 10), // Tạo khoảng cách nhỏ giữa label và value để không dính sát nhau

          // Phần Value (bên phải) - Sửa ở đây
          Expanded( 
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.right, // Căn lề phải cho đẹp
              softWrap: true, // Cho phép xuống dòng
            ),
          ),
        ],
      ),
    );
  }
}