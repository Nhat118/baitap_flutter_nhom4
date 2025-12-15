import 'package:flutter/material.dart';

// --- IMPORT CÁC BÀI TẬP CỦA BẠN ---
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
import 'new_list_page.dart';

// --- MAP ÁNH XẠ BÀI TẬP ---
final Map<String, Widget> assignmentWidgets = {
  'Hello World': const MyHomePage(),
  'Layout': const GuideToLayout(),
  'My Class': const MyClass(),
  'My Place': const MyPlace(),
  'Đổi Màu Nền': const ColorChanger(),
  'Tính BMI': const BMI(),
  'Đếm Số': const CountNumber(),
  'Đếm thời gian': const CountdownTimer(),
  'Đăng Ký': const Register(),
  'Form Đăng Nhập': Login(),
  'Phản hồi': const FeedbackForm(),
  'Cửa Hàng': const MyProduct(),
  'Tin Tức': const NewsListPage(),
  'Đăng Nhập API': LoginAPI(),
};

// --- WIDGET CHÍNH (MÀN HÌNH) ---
class Ngoquylongnhat extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const Ngoquylongnhat({
    super.key, 
    required this.isDark, 
    required this.onToggleTheme
  });

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
        actions: [
          IconButton(
            tooltip: widget.isDark ? 'Chuyển sang sáng' : 'Chuyển sang tối',
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avt.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 300,
        // Đặt màu nền cho Drawer để phù hợp với chế độ tối
        backgroundColor: widget.isDark ? const Color(0xFF1E1E1E) : Colors.white,
        child: NgoQuyLongNhatSidebar(
          assignments: assignmentWidgets.keys.toList(),
          selectedKey: _selectedAssignmentKey,
          onSelect: _selectAssignment,
          isDark: widget.isDark, // Truyền biến isDark xuống Sidebar
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _currentContent,
      ),
    );
  }
}

// --- WIDGET SIDEBAR (ĐÃ GỘP VÀ CẬP NHẬT LOGIC MÀU SẮC) ---
class NgoQuyLongNhatSidebar extends StatelessWidget {
  final List<String> assignments;
  final String selectedKey;
  final Function(String) onSelect;
  final bool isDark; // Nhận biến isDark để chỉnh màu

  const NgoQuyLongNhatSidebar({
    super.key,
    required this.assignments,
    required this.selectedKey,
    required this.onSelect,
    required this.isDark, // Bắt buộc truyền vào
  });

  @override
  Widget build(BuildContext context) {
    // Định nghĩa màu sắc dựa trên isDark
    final Color normalTextColor = isDark ? Colors.white : Colors.black87;
    final Color normalIconColor = isDark ? Colors.white70 : Colors.grey;
    final Color selectedTextColor = isDark ? Colors.lightBlueAccent : Colors.blue.shade900;
    final Color selectedTileColor = isDark ? Colors.blue.withOpacity(0.2) : Colors.blue.shade50;
    final Color footerColor = isDark ? Colors.grey.shade400 : Colors.grey;

    return Column(
      children: [
        // Phần Header "Xịn sò" có Avatar và info
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
          ),
          accountName: const Text(
            "Ngô Quý Long Nhật",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          accountEmail: const Text("22T1020284 - Nhóm 4"),
          currentAccountPicture: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avt.jpg'),
          ),
        ),

        // Danh sách cuộn
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Nút về Trang Chủ
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Trang Chủ (My Profile)"),
                selected: selectedKey == 'Trang Chủ',
                selectedTileColor: selectedTileColor,
                // Chỉnh màu chữ/icon theo trạng thái
                textColor: selectedKey == 'Trang Chủ' ? selectedTextColor : normalTextColor,
                iconColor: selectedKey == 'Trang Chủ' ? selectedTextColor : normalTextColor,
                onTap: () => onSelect('Trang Chủ'),
              ),
              Divider(color: isDark ? Colors.white24 : Colors.grey.shade300),

              // Danh sách các bài tập
              ...assignments.map((key) {
                final bool isActive = key == selectedKey;
                return ListTile(
                  leading: Icon(
                    isActive ? Icons.folder_open : Icons.folder,
                    // Màu icon
                    color: isActive ? selectedTextColor : normalIconColor,
                  ),
                  title: Text(
                    key,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      // Màu chữ
                      color: isActive ? selectedTextColor : normalTextColor,
                    ),
                  ),
                  tileColor: isActive ? selectedTileColor : null,
                  onTap: () => onSelect(key),
                );
              }).toList(),
            ],
          ),
        ),

        // Footer nhỏ
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Ver 1.0 - Bài tập Flutter Nhóm 4",
            style: TextStyle(color: footerColor, fontSize: 12),
          ),
        ),
      ],
    );
  }
}