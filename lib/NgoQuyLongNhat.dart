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

// --- MAP ICON VÀ MÀU CHO MỖI BÀI TẬP ---
final Map<String, Map<String, dynamic>> assignmentConfig = {
  'Hello World': {'icon': Icons.public, 'colors': [Color(0xFF667EEA), Color(0xFF764BA2)]},
  'Layout': {'icon': Icons.dashboard, 'colors': [Color(0xFFF093FB), Color(0xFFF5576C)]},
  'My Class': {'icon': Icons.school, 'colors': [Color(0xFF4FACFE), Color(0xFF00F2FE)]},
  'My Place': {'icon': Icons.place, 'colors': [Color(0xFFFA709A), Color(0xFFFECE34)]},
  'Đổi Màu Nền': {'icon': Icons.palette, 'colors': [Color(0xFFA8EDEA), Color(0xFFFED6E3)]},
  'Tính BMI': {'icon': Icons.favorite, 'colors': [Color(0xFFFF9A56), Color(0xFFFF6A88)]},
  'Đếm Số': {'icon': Icons.numbers, 'colors': [Color(0xFF30B0FE), Color(0xFF5A29E8)]},
  'Đếm thời gian': {'icon': Icons.timer, 'colors': [Color(0xFFFFA630), Color(0xFFFF6B6B)]},
  'Đăng Ký': {'icon': Icons.app_registration, 'colors': [Color(0xFF11998E), Color(0xFF38EF7D)]},
  'Form Đăng Nhập': {'icon': Icons.login, 'colors': [Color(0xFF667eea), Color(0xFF764ba2)]},
  'Phản hồi': {'icon': Icons.feedback, 'colors': [Color(0xFFf093fb), Color(0xFFf5576c)]},
  'Cửa Hàng': {'icon': Icons.shopping_cart, 'colors': [Color(0xFF4facfe), Color(0xFF00f2fe)]},
  'Tin Tức': {'icon': Icons.newspaper, 'colors': [Color(0xFFfa709a), Color(0xFFfece34)]},
  'Đăng Nhập API': {'icon': Icons.api, 'colors': [Color(0xFF43e97b), Color(0xFF38f9d7)]},
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

  // --- SỬA LẠI HÀM NÀY: Bỏ dòng Navigator.pop() đi ---
  void _selectAssignment(String key) {
    setState(() {
      _selectedAssignmentKey = key;
    });
  }

  // Widget hiển thị nội dung
  Widget get _currentContent {
    if (_selectedAssignmentKey == 'Trang Chủ') {
      return _buildHomePageWithAssignments();
    }
    if (assignmentWidgets.containsKey(_selectedAssignmentKey)) {
      return assignmentWidgets[_selectedAssignmentKey]!;
    }
    return const Center(child: Text("Không tìm thấy nội dung"));
  }

  // Trang chủ với profile + danh sách bài tập
  Widget _buildHomePageWithAssignments() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile
          const MyProfile(),
          
          // Divider với hiệu ứng
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              children: [
                Divider(thickness: 2, color: Theme.of(context).dividerColor),
                const SizedBox(height: 8),
                Text(
                  'Các Bài Tập',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(thickness: 2, color: Theme.of(context).dividerColor),
              ],
            ),
          ),
          
          // Grid danh sách bài tập
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Quan trọng để cuộn cùng Profile
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: assignmentWidgets.length,
              itemBuilder: (context, index) {
                final key = assignmentWidgets.keys.toList()[index];
                return _buildAssignmentCard(key, index);
              },
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(String title, int index) {
    final config = assignmentConfig[title] ?? {'icon': Icons.assignment, 'colors': [Colors.blue.shade400, Colors.blue.shade600]};
    final colors = config['colors'] as List<Color>;
    final icon = config['icon'] as IconData;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.first.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: InkWell(
            // --- GỌI HÀM SELECT Ở ĐÂY (Không Pop) ---
            onTap: () => _selectAssignment(title),
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isHomePage = _selectedAssignmentKey == 'Trang Chủ';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isHomePage ? 'Ngô Quý Long Nhật' : _selectedAssignmentKey,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        // Nút Back chỉ hiện khi không phải trang chủ
        leading: isHomePage
            ? null // Để mặc định hiện nút Menu (Hamburger)
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _selectAssignment('Trang Chủ'); // Quay về trang chủ
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
        backgroundColor: widget.isDark ? const Color(0xFF1E1E1E) : Colors.white,
        child: NgoQuyLongNhatSidebar(
          assignments: assignmentWidgets.keys.toList(),
          selectedKey: _selectedAssignmentKey,
          // --- SỬA LẠI LOGIC KHI CHỌN TỪ SIDEBAR ---
          onSelect: (key) {
            _selectAssignment(key); // Chọn bài
            Navigator.of(context).pop(); // Đóng Sidebar thủ công tại đây
          },
          isDark: widget.isDark,
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