import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Pindah otomatis ke dashboard setelah 5 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Judul aplikasi
            const Text(
              'UTS Pemrograman Mobile',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Ganti dengan foto kamu (taruh di folder assets/images/)
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/foto.jpg'),
            ),
            const SizedBox(height: 20),

            // Nama dan NIM
            const Text(
              'Fadli Ahmad Fahrezi',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const Text(
              'NIM: 152023047',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),

            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
