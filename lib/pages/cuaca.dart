import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// --- DATA MODEL (untuk menyimpan data cuaca) ---

class Forecast {
  final String day;
  final String temp;
  final IconData icon;
  Forecast(this.day, this.temp, this.icon);
}

class WeatherData {
  final String location;
  final String temperature;
  final String condition;
  final String lottieAsset;
  final String humidity;
  final String wind;
  final String uvIndex;
  final List<Forecast> forecast;

  WeatherData({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.lottieAsset,
    required this.humidity,
    required this.wind,
    required this.uvIndex,
    required this.forecast,
  });
}

// --- WIDGET UTAMA (Stateful) ---

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  // --- DATA STATIS UNTUK 3 KOTA ---
  final Map<String, WeatherData> _weatherDataMap = {
    'Bandung': WeatherData(
      location: 'Bandung, Indonesia',
      temperature: '22°',
      condition: 'Berawan Sebagian',
      lottieAsset: 'assets/lottie/berawan.json', // <-- Pastikan file ini ada
      humidity: '86%',
      wind: '12 km/j',
      uvIndex: 'Rendah',
      forecast: [
        Forecast('Besok', '21°/17°', Icons.cloudy_snowing),
        Forecast('Jumat', '24°/18°', Icons.wb_sunny_rounded),
        Forecast('Sabtu', '23°/17°', Icons.thunderstorm_rounded),
        Forecast('Minggu', '22°/17°', Icons.cloud_rounded),
        Forecast('Senin', '20°/16°', Icons.grain_rounded), // Hujan
        Forecast('Selasa', '24°/18°', Icons.wb_sunny_rounded),
        Forecast('Rabu', '23°/17°', Icons.cloud_rounded),
      ],
    ),
    'Jakarta': WeatherData(
      location: 'Jakarta, Indonesia',
      temperature: '31°',
      condition: 'Cerah',
      lottieAsset: 'assets/lottie/cerah.json',
      humidity: '75%',
      wind: '10 km/j',
      uvIndex: 'Tinggi',
      forecast: [
        Forecast('Besok', '32°/25°', Icons.wb_sunny_rounded),
        Forecast('Jumat', '33°/26°', Icons.wb_sunny_rounded),
        Forecast('Sabtu', '32°/25°', Icons.cloud_rounded),
        Forecast('Minggu', '31°/25°', Icons.wb_sunny_rounded),
        Forecast('Senin', '33°/26°', Icons.wb_sunny_rounded),
        Forecast('Selasa', '32°/25°', Icons.cloud_rounded),
        Forecast('Rabu', '31°/25°', Icons.wb_sunny_rounded),
      ],
    )
  };

  // State untuk menyimpan kota yang sedang dipilih
  String _selectedCity = 'Bandung';
  late WeatherData _currentWeather;

  @override
  void initState() {
    super.initState();
    // Atur cuaca awal berdasarkan kota default
    _currentWeather = _weatherDataMap[_selectedCity]!;
  }

  // Fungsi untuk update UI saat kota diganti
  void _updateWeather(String? newCity) {
    if (newCity != null) {
      setState(() {
        _selectedCity = newCity;
        _currentWeather = _weatherDataMap[newCity]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current Weather Card
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue[400]!,
                    Colors.purple[400]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // --- KOTA DIGANTI JADI DROPDOWN ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedCity,
                          onChanged: _updateWeather,
                          items: _weatherDataMap.keys.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          // Styling agar cocok dengan desain
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          icon: const Icon(Icons.arrow_drop_down_rounded,
                              color: Colors.white),
                          dropdownColor: Colors.blue[700],
                          underline: Container(), // Hapus garis bawah
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Weather Animation (dinamis)
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Lottie.asset(
                        _currentWeather.lottieAsset, // Data dinamis
                        width: 120,
                        height: 120,
                        // Error handling jika file Lottie tidak ada
                        errorBuilder: (context, error, stackTrace) {
                           return const Icon(Icons.cloud_off_rounded, color: Colors.white, size: 60);
                        },
                      ),
                    ),

                    // Temperature (dinamis)
                    Text(
                      _currentWeather.temperature, // Data dinamis
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),

                    // Weather Condition (dinamis)
                    Text(
                      _currentWeather.condition, // Data dinamis
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Additional Info (dinamis)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoColumn(Icons.water_drop_rounded,
                              'Kelembapan', _currentWeather.humidity),
                          _buildInfoColumn(
                              Icons.air_rounded, 'Angin', _currentWeather.wind),
                          _buildInfoColumn(Icons.wb_sunny_rounded, 'UV Index',
                              _currentWeather.uvIndex),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Forecast Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded,
                          color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Prakiraan 7 Hari', // Diubah jadi 7 hari
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // --- PRAKIRAAN 7 HARI (DINAMIS) ---
                  // Menggunakan 'spread operator' (...) untuk 
                  // mengubah List<Widget> menjadi widget individual
                  ..._currentWeather.forecast.map((forecast) {
                    return _buildForecastCard(
                        forecast.day, forecast.temp, forecast.icon);
                  }).toList(),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGET (Tidak perlu diubah) ---

  Widget _buildInfoColumn(IconData icon, String title, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            )),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _buildForecastCard(String day, String temp, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(day,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )),
          ),
          Text(temp,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              )),
        ],
      ),
    );
  }
}