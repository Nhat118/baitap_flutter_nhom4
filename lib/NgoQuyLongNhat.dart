import 'package:flutter/material.dart';
// Import các bài tập của bạn
import 'guide_to_layout.dart';
import 'my_class.dart';
import 'my_place.dart';
import 'my_home_page.dart';
import 'doi_mau.dart';
import 'bmi.dart';
import 'CountdownTimer.dart';
import 'dangky.dart';
import 'dem_so.dart';
import 'feedback.dart';
import 'my_product.dart';
import 'form_dangnhap.dart';
import 'dang_nhap.dart';
import 'NgoQuyLongNhatProfile.dart';
import 'NgoQuyLongNhatSidebar.dart';
import 'new_list_page.dart';
// Map ánh xạ bài tập
final Map<String, Widget> assignmentWidgets = {
  'My Home Page': const MyHomePage(),
  'Layout Guide': const GuideToLayout(),
  'My Class': const MyClass(),
  'My Place': const MyPlace(),
  'Đổi Màu Nền': const ColorChanger(),
  'Tính BMI': const BMI(),
  'Đếm thời gian': const CountdownTimer(),
  'Đăng Ký': const Register(),
  'Form Đăng Nhập': Login(),
  'Đếm Số': const CountNumber(),
  'Feedback': const FeedbackForm(),
  'Cửa Hàng': const MyProduct(),
  'Tin Tức': const NewsListPage(),
  'Đăng Nhập API': LoginAPI(),
};

class Ngoquylongnhat extends StatefulWidget {
  const Ngoquylongnhat({super.key});

  @override
  State<Ngoquylongnhat> createState() => _NgoquylongnhatState();
}

class _NgoquylongnhatState extends State<Ngoquylongnhat> {
  // Mặc định là 'Trang Chủ'
  String _selectedAssignmentKey = 'Trang Chủ';

  void _selectAssignment(String key) {
    setState(() {
      _selectedAssignmentKey = key;
    });
    // Đóng Sidebar sau khi chọn
    Navigator.of(context).pop();
  }

  // Widget hiển thị nội dung
  Widget get _currentContent {
    if (_selectedAssignmentKey == 'Trang Chủ') {
      return const MyProfile();
    }
    if (assignmentWidgets.containsKey(_selectedAssignmentKey)) {
      return assignmentWidgets[_selectedAssignmentKey]!;
    }
    return const Center(child: Text("Không tìm thấy nội dung"));
  }

  @override
  Widget build(BuildContext context) {
    // Biến kiểm tra xem có đang ở trang chủ không
    bool isHomePage = _selectedAssignmentKey == 'Trang Chủ';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isHomePage ? 'Ngô Quý Long Nhật' : _selectedAssignmentKey,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        leading: isHomePage
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedAssignmentKey = 'Trang Chủ';
            });
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('LN', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 300,
        // Sửa tên class cho khớp với đoạn code 2 (chữ Q, L, N viết hoa)
        child: NgoQuyLongNhatSidebar( 
          assignments: assignmentWidgets.keys.toList(),
          selectedKey: _selectedAssignmentKey,
          onSelect: _selectAssignment,
        ),
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: _currentContent,
      ),
    );
  }
}

class NgoquylongnhatSidebar extends StatelessWidget {
  final List<String> assignments;
  final String selectedKey;
  final Function(String) onSelect;

  const NgoquylongnhatSidebar({
    required this.assignments,
    required this.selectedKey,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Text(
                  'LN',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ngô Quý Long Nhật',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '22T1020284',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Trang Chủ'),
          selected: selectedKey == 'Trang Chủ',
          onTap: () => onSelect('Trang Chủ'),
        ),
        const Divider(),
        ...assignments.map((assignment) {
          return ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(assignment),
            selected: selectedKey == assignment,
            onTap: () => onSelect(assignment),
          );
        }).toList(),
      ],
    );
  }
}