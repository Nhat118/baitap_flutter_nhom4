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
        image: 'https://images.unsplash.com/photo-1626117736969-69db1f4aa790?q=80&w=1180&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
      Course(
        title: 'Flutter cơ bản',
        instructor: 'An Bùi',
        students: '120 students',
        image: 'https://images.unsplash.com/photo-1560707303-4e980ce876ad?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
      Course(
        title: 'Lập trình Android nâng cao',
        instructor: 'Minh Trần',
        students: '80 students',
        image: 'https://images.unsplash.com/photo-1571488740944-f1a0416a45a0?q=80&w=1167&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
      Course(
        title: 'CSDL và SQL',
        instructor: 'Hằng Lê',
        students: '200 students',
        image: 'https://images.unsplash.com/photo-1677127853510-5f96275c72ba?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
       Course(
        title: 'Toán rời rạc',
        instructor: 'Long Nhật',
        students: '60 students',
        image:
            'https://images.unsplash.com/photo-1557750255-c76072a7aad1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
      margin: EdgeInsets.only(top: 0,left: 10,right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          opacity: 0.6
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
