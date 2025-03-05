import 'package:flutter/material.dart';

class ChargingHistory extends StatefulWidget {
  const ChargingHistory({super.key});

  @override
  State<ChargingHistory> createState() => _ChargingHistoryState();
}

class _ChargingHistoryState extends State<ChargingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text("hukapan dan", style: TextStyle(fontSize: 80))),
    );
  }
}