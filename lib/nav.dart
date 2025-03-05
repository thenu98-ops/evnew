import 'package:ev/services/firebasemodel.dart';
import 'package:flutter/material.dart';
import 'pages/e_wallet_screen.dart';
import 'package:ev/pages/profile_screen.dart';
import 'pages/search_screen.dart';
import 'register.dart';
import 'pages/charging_screen.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const EWalletScreen(),
    const ChargingScreen(),
    const SearchScreen(),
    const ProfileScreen(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_selectedIndex]), // Prevents UI overlap
      bottomNavigationBar: SafeArea( // Prevents bottom overflow
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4), // Smaller bottom padding
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10), // Reduced margin
            padding: const EdgeInsets.symmetric(vertical: 6), // Reduced vertical padding
            decoration: BoxDecoration(
              color: const Color(0xFFE6F9F7), // Slightly lighter color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.account_balance_wallet, "eWallet", 0),
                _buildNavItem(Icons.ev_station, "Charging", 1),
                _buildNavItem(Icons.search, "Search", 2),
                _buildNavItem(Icons.person_2_rounded, "Profile", 3),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFB8EAE2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12), // Slightly smaller radius
          ),
          padding: const EdgeInsets.symmetric(vertical: 6), // Reduced padding
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unnecessary space
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.black : Colors.grey[700],
                size: 22, // Reduced icon size
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12, // Reduced text size
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
