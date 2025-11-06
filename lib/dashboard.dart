import 'package:flutter/material.dart';
import 'pages/biodata.dart';
import 'pages/kontak.dart';
import 'pages/kalkulator.dart';
import 'pages/cuaca.dart';
import 'pages/berita.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    BiodataPage(),
    KontakPage(),
    KalkulatorPage(),
    CuacaPage(),
    BeritaPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard UTS Mobile'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Biodata'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Kalkulator'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Berita'),
        ],
      ),
    );
  }
}
