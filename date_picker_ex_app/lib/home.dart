import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Color _backgroundColor;
  late String _currentDateTimeText;
  late String _selectDateTimeText;
  DateTime? _selectDateTime;

  @override
  void initState() {
    super.initState();
    _currentDateTimeText = "";
    _selectDateTimeText = "아직 시간을 선택하지 않았습니다.";
    _backgroundColor = Colors.white;
    Timer.periodic(Duration(seconds: 1), (timer) {
      refreshNowTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          '알람 정하기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 시간 : $_currentDateTimeText',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {
                  _selectDateTime = value;
                },
              ),
            ),
            Text(
              _selectDateTimeText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  } // build

  // === Functions ===

  void refreshNowTime() {
    DateTime currentDateTime = DateTime.now();
    _currentDateTimeText = returnNowTime(currentDateTime);
    checkNowTimeWithSelectTime(currentDateTime);
    setState(() {});
  }

  void checkNowTimeWithSelectTime(DateTime now) {
    if (_selectDateTime != null) {
      _selectDateTimeText =
          '선택한 시간 : ${returnNowTimeExceptSeconds(_selectDateTime!)}';
      if (now.year == _selectDateTime!.year &&
          now.month == _selectDateTime!.month &&
          now.day == _selectDateTime!.day &&
          now.hour == _selectDateTime!.hour &&
          now.minute == _selectDateTime!.minute) {
        
        _backgroundColor = now.second % 2 == 0? Colors.amberAccent:Colors.redAccent;
      } else {
        _backgroundColor = Colors.white;
      }
    } else {
      _selectDateTimeText = "아직 시간을 선택하지 않았습니다.";
    }
  }

  String returnNowTimeExceptSeconds(DateTime now) {
    return '${now.year}-${returnStringPadLeft(now.month)}-${returnStringPadLeft(now.day)} ${returnWeekdayToString(now.weekday)}'  
    '  ${returnStringPadLeft(now.hour)}:${returnStringPadLeft(now.minute)}';
  }

  String returnNowTime(DateTime now) {
    return '${now.year}-${returnStringPadLeft(now.month)}-${returnStringPadLeft(now.day)} ${returnWeekdayToString(now.weekday)}'    
    '  ${returnStringPadLeft(now.hour)}:${returnStringPadLeft(now.minute)}:${returnStringPadLeft(now.second)}';
  }

  String returnStringPadLeft(int time) {
    return time.toString().padLeft(2, '0');
  }

  String returnWeekdayToString(int weekDay) {
    String dateName = "일";
    switch (weekDay) {
      case 1:
        dateName = "월";
      case 2:
        dateName = "화";
      case 3:
        dateName = "수";
      case 4:
        dateName = "목";
      case 5:
        dateName = "금";
      case 6:
        dateName = "토";
      default:
        dateName = "월";
    }
    return dateName;
  }
}
