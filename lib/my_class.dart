import 'package:flutter/material.dart';

class MyClass extends StatelessWidget {
  const MyClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBody(),
    );
  }
  Widget myBody() {
    // Sample data for the list. Edit this list to change what is displayed.
    final data = <Course>[
      Course(
        title: 'XML và ứng dụng - Nhóm 1',
        instructor: 'Dũng Nguyễn',
        students: '50 students',
        image: 'assets/images/anh1.jpg',
      ),
      Course(
        title: 'Flutter cơ bản',
        instructor: 'An Bùi',
        students: '120 students',
        image: 'assets/images/anh2.jpg',
      ),
      Course(
        title: 'Lập trình Android nâng cao',
        instructor: 'Minh Trần',
        students: '80 students',
        image: 'assets/images/anh3.jpg',
      ),
      Course(
        title: 'CSDL và SQL',
        instructor: 'Hằng Lê',
        students: '200 students',
        image: 'assets/images/anh4.jpg',
      ),
       Course(
        title: 'Toán rời rạc',
        instructor: 'Long Nhật',
        students: '60 students',
        image:'assets/images/anh5.jpg',
      ),
       Course(
        title: 'Java nâng cao',
        instructor: 'Nguyễn Hoàng Hà',
        students: '40 students',
        image:'assets/images/anh6.jpg',
      ),
      Course(
        title: 'Đồ án Công nghệ phần mềm',
        instructor: 'Trần Nguyên Phong',
        students: '40 students',
        image:'assets/images/anh7.jpg',
      ),
      Course(
        title: 'Giải tích',
        instructor: 'Nguyễn Văn Trung',
        students: '70 students',
        image:'assets/images/anh8.jpg',
      ),
    ];

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return item(data[index]);
      },
    );
  }
  Widget item(Course course) {
    final title = course.title;
    final instructor = course.instructor;
    final students = course.students;
    final image = course.image;

    return Container(
      height: 120,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          opacity: 0.8
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('Instructor: $instructor')
                ],
              ),
            Text(students)
            ],
          ),
        IconButton(onPressed:(){
          print("Hello");
        }, icon: Icon(Icons.more_horiz))
        ],
      ),
    );
  }
}

class Course {
  final String title;
  final String instructor;
  final String students;
  final String image;

  Course({
    required this.title,
    required this.instructor,
    required this.students,
    required this.image,
  });
}
