import 'package:flutter/material.dart';

class NgoQuyLongNhatSidebar extends StatelessWidget {
  final List<String> assignments;
  final String selectedKey;
  final Function(String) onSelect;

  const NgoQuyLongNhatSidebar({
    super.key,
    required this.assignments,
    required this.selectedKey,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.white,
            child: Text(
              "LN",
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
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
                selectedTileColor: Colors.blue.shade100,
                selectedColor: Colors.blue.shade900,
                onTap: () => onSelect('Trang Chủ'),
              ),
              const Divider(),

              // Danh sách các bài tập
              ...assignments.map((key) {
                final bool isActive = key == selectedKey;
                return ListTile(
                  leading: Icon(
                    isActive ? Icons.folder_open : Icons.folder,
                    color: isActive ? Colors.blue.shade800 : Colors.grey,
                  ),
                  title: Text(
                    key,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? Colors.blue.shade900 : Colors.black87,
                    ),
                  ),
                  tileColor: isActive ? Colors.blue.shade50 : null,
                  onTap: () => onSelect(key),
                );
              }).toList(),
            ],
          ),
        ),

        // Footer nhỏ (Tuỳ chọn)
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Ver 1.0 - Bài tập Flutter Nhóm 4",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}