import 'package:flutter/material.dart';

class Performance extends StatefulWidget {
  const Performance({Key? key}) : super(key: key);

  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('PerformancePage',style: TextStyle(fontSize: 24)),
    );
  }
}
