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

  final List<String> _pageTitles = [
    'Biodata Mahasiswa',
    'Daftar Kontak',
    'Kalkulator',
    'Info Cuaca',
    'Berita Terkini',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[700]!,
                Colors.blue[800]!
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue[700],
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                activeIcon: Icon(Icons.person_rounded, size: 26),
                label: 'Biodata',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contacts_rounded),
                activeIcon: Icon(Icons.contacts_rounded, size: 26),
                label: 'Kontak',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_rounded),
                activeIcon: Icon(Icons.calculate_rounded, size: 26),
                label: 'Kalkulator',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_rounded),
                activeIcon: Icon(Icons.cloud_rounded, size: 26),
                label: 'Cuaca',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_rounded),
                activeIcon: Icon(Icons.article_rounded, size: 26),
                label: 'Berita',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
