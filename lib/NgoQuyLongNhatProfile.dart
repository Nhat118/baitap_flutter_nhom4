import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String assignmentName = "Thông Tin Sinh Viên"; 

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60, 
                    backgroundImage: AssetImage('assets/images/avt.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  
                  const SizedBox(height: 10),
                  Text(
                    "Ngô Quý Long Nhật", 
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Color(0xFF1E3A8A)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Divider(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                  const SizedBox(height: 10),
                  _buildRowInfo("Học Phần:", "Lập trình ứng dụng cho các thiết bị di động", isDark),
                  _buildRowInfo("Mã Sinh Viên:", "22T1020284", isDark),
                  _buildRowInfo("Nhóm:", "Nhóm 4", isDark),
                  _buildRowInfo("Giảng Viên:", "ThS. Nguyễn Dũng", isDark),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRowInfo(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: isDark ? Colors.grey.shade400 : Colors.grey
            )
          ),
          
          const SizedBox(width: 10),

          Expanded( 
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black
              ),
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}