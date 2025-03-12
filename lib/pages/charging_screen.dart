import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'charging_history.dart';

class ChargingScreen extends StatefulWidget {
  const ChargingScreen({super.key});

  @override
  State<ChargingScreen> createState() => _ChargingScreenState();
}

class _ChargingScreenState extends State<ChargingScreen> {
  final TextEditingController _referenceCodeController = TextEditingController();
  bool _isCharging = false;
  bool _isChargerConnected = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  QRViewController? _qrController;
  bool _isScanning = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    _qrController?.dispose();
    _referenceCodeController.dispose();
    super.dispose();
  }

  Future<void> _toggleCharging() async {
    final String referenceCode = _referenceCodeController.text.trim();
    if (referenceCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reference code or scan a QR code.')),
      );
      return;
    }

    final User? user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
      return;
    }

    try {
      final doc = await _firestore.collection('station_control').doc(referenceCode).get();
      if (doc.exists) {
        setState(() {
          _isChargerConnected = true;
        });

        if (_isCharging) {
          // Stop charging
          await _firestore.collection('profile').doc(user.uid).update({
            'isCharging': false,
          });

          await _firestore.collection('station_control').doc(referenceCode).update({
            'isCharging': false,
          });

          setState(() {
            _isCharging = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Charging stopped successfully!')),
          );
        } else {
          // Start charging
          await _firestore.collection('profile').doc(user.uid).update({
            'isCharging': true,
          });

          await _firestore.collection('station_control').doc(referenceCode).update({
            'isCharging': true,
          });

          setState(() {
            _isCharging = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Charging started successfully!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid reference code. Please enter a valid code.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _startQRScan() {
    setState(() {
      _isScanning = true;
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        setState(() {
          _referenceCodeController.text = scanData.code!;
          _isScanning = false;
        });
        _qrController?.dispose();
      }
    });
  }

  void _navigateToHistoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChargingHistory()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Charger'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF87C159),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Charging',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF87C159)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/charger.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _referenceCodeController,
                  decoration: InputDecoration(
                    labelText: 'Enter Reference Code',
                    labelStyle: const TextStyle(color: Color(0xFF87C159)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF87C159)),
                      onPressed: _startQRScan,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleCharging,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCharging ? Colors.red : const Color(0xFFD9F101),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    _isCharging ? 'Stop Charging' : 'Start Charging',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _navigateToHistoryScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF87C159),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'View Charging History',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (_isScanning)
            Positioned.fill(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: const Color(0xFF87C159),
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
