import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CuacaPage extends StatelessWidget {
  const CuacaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Widget Cuaca Utama (meniru gambar )
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.purple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Bandung, Indonesia',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Ganti 'assets/lottie/weather.json' dengan file Anda
                    Lottie.asset(
                      'assets/lottie/berawan.json',
                      width: 150,
                      height: 150,
                    ),
                    const Text(
                      '22°',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const Text(
                      'Berawan Sebagian',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    // Info tambahan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoColumn(
                            Icons.water_drop, 'Kelembapan', '86%'),
                        _buildInfoColumn(Icons.air, 'Angin', '12 km/j'),
                        _buildInfoColumn(
                            Icons.wb_sunny, 'UV Index', 'Rendah'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Widget Prakiraan (meniru gambar )
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Prakiraan 3 Hari',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildForecastCard('Besok', '21°/17°', Icons.cloudy_snowing),
            _buildForecastCard('Jumat', '24°/18°', Icons.wb_sunny),
            _buildForecastCard('Sabtu', '23°/17°', Icons.thunderstorm),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk info kelembapan, angin, dll.
  Widget _buildInfoColumn(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple, size: 30),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  // Helper widget untuk card prakiraan harian
  Widget _buildForecastCard(String day, String temp, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple, size: 30),
        title: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(temp, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}