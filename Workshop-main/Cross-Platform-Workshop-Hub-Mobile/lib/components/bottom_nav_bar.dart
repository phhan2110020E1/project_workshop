import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: screenHeight * 0.02),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white70,
          tabBackgroundColor: Colors.grey.shade600,
          onTabChange: (value) => onTabChange!(value),
          gap: 8,
          padding: EdgeInsets.all(screenHeight * 0.02),
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: 'Home',
            ),
            GButton(
              icon: Icons.snippet_folder_outlined,
              text: 'Manage',
            ),
            GButton(
              icon: Icons.people_alt_outlined,
              text: 'Workshop',
            ),
            GButton(
              icon: Icons.wallet,
              text: 'Wallet',
            ),
            GButton(
              icon: Icons.qr_code,
              text: 'Qr Demo',
            ),
          ],
        ),
      ),
    );
  }
}
