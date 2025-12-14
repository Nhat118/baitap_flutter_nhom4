import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  var _remain = 0;

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remain = int.tryParse(_controller.text)??0;
    });
    _timer = Timer.periodic(Duration(seconds: 1),(timer){
      if(_remain >0){
        setState(() {
          _remain --;
        });
      }else{
        timer.cancel();
      }
    });
  }
  void _resetTimer(){
    _timer?.cancel();
    setState(() {
      _remain=0;
      _controller.clear();
    });
  }


  String _formatDuration(Duration duration){
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m ${seconds}s';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
  Widget mybody() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Nhập số giây cần đếm", style: TextStyle(fontSize: 30.0)),
          SizedBox(height: 20.0),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Nhập số giây",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20.0),
          Text(_formatDuration(Duration(seconds: _remain)),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue ),),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startTimer,
                child: Row(
                  children: [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 10.0),
                    Text("Bắt đầu"),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Row(
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 10.0),
                    Text("Đặt lại"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
title: Center(child: Text("Bộ đếm thời gian")),
        backgroundColor: Colors.blue,
      ),
      body: mybody(),
    );
  }
}