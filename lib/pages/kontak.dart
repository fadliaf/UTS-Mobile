import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> kontakList = [
      {'nama': 'Ahmad', 'telepon': '081234567890', 'foto': 'assets/images/kontak.png'},
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
      backgroundColor: Colors.transparent,
      body: Column(
        children: [

          // List Kontak
          Expanded(
            child: ListView.builder(
              itemCount: kontakList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final kontak = kontakList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[400]!,
                              Colors.purple[400]!,
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(kontak['foto']!),
                        ),
                      ),
                      title: Text(
                        kontak['nama']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        kontak['telepon']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.call_rounded, 
                              color: Colors.green[600], size: 22),
                          onPressed: () {
                            _showCallDialog(context, kontak['nama']!);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCallDialog(BuildContext context, String nama) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.phone_rounded, 
            color: Colors.green, size: 50),
        content: Text(
          'Menelepon $nama...',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}