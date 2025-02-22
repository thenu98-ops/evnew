import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isCharging = false;

  @override
  void initState() {
    super.initState();
    _loadChargingStatus(); // Load initial value from Firebase
  }

  Future<void> _loadChargingStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('profile')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        isCharging = (userDoc.data() as Map<String, dynamic>)['isCharging'] ?? false;
      });
    }
  }

  Future<void> _toggleCharging(bool value) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      isCharging = value;
    });

    await FirebaseFirestore.instance
        .collection('profile')
        .doc(user.uid)
        .update({"isCharging": value}).catchError((error) {
      print("❌ Error updating isCharging: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Charger Control")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Charging Status: ${isCharging ? "ON" : "OFF"}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: isCharging,
              onChanged: _toggleCharging,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
