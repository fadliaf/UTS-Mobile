import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar kontak statis
    final List<Map<String, String>> kontakList = [
      {'nama': 'Ahmad ', 'telepon': '081234567890', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Udin Petot', 'telepon': '081234567891', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Rizky Maulana', 'telepon': '081234567892', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Siti Rahma', 'telepon': '081234567893', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Dewi Anggraeni', 'telepon': '081234567894', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Budi Santoso', 'telepon': '081234567895', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Citra Ningsih', 'telepon': '081234567896', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Yusuf Kurniawan', 'telepon': '081234567897', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Andi Pratama', 'telepon': '081234567898', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Nurul Hidayah', 'telepon': '081234567899', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Faisal Rahman', 'telepon': '081234567800', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Intan Sari', 'telepon': '081234567801', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Agus Firmansyah', 'telepon': '081234567802', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Rahmat Setiawan', 'telepon': '081234567803', 'foto': 'assets/images/kontak.png'},
      {'nama': 'Tiara Amelia', 'telepon': '081234567804', 'foto': 'assets/images/kontak.png'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemCount: kontakList.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final kontak = kontakList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage(kontak['foto']!),
              ),
              title: Text(
                kontak['nama']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(kontak['telepon']!),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Menelepon ${kontak['nama']}...'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
