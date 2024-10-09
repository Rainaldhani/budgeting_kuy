import 'package:budgeting_kuy/src/features/data_entry_screen.dart';

import 'package:budgeting_kuy/src/features/history.dart';
import 'package:budgeting_kuy/src/features/main_screen_mobile.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  final List _pages = [
    ListMainScreen(),
    EntryDataScreen(tipe: "Pengeluaran"),
    EntryDataScreen(tipe: "Pemasukan"),
    History()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigateBottomBar,
        currentIndex: _selectedIndex,
        backgroundColor: const Color.fromARGB(255, 241, 221, 130),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_up),
            label: 'Keluar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_down),
            label: 'Masuk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
