import 'package:flutter/material.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> beritaList = [
      {
        "judul": "Teknologi AI Semakin Diminati di Indonesia",
        "ringkasan":
            "Banyak startup lokal mulai mengintegrasikan AI untuk meningkatkan efisiensi bisnis mereka, terutama di sektor e-commerce dan pendidikan.",
        "gambar": "assets/images/berita_ai.jpeg",
        "kategori": "Teknologi",
        "waktu": "2 jam lalu",
        "isi":
            "Perkembangan kecerdasan buatan (AI) di Indonesia mengalami peningkatan signifikan dalam beberapa tahun terakhir. Banyak startup dan perusahaan mulai memanfaatkan teknologi AI untuk mendukung layanan pelanggan, analisis data, hingga otomasi industri. Pemerintah pun menyiapkan berbagai inisiatif untuk mempercepat adopsi AI secara nasional."
      },
      {
        "judul": "Cuaca Ekstrem Melanda Beberapa Wilayah",
        "ringkasan":
            "BMKG memperingatkan potensi hujan deras disertai angin kencang di beberapa wilayah di Indonesia selama minggu ini.",
        "gambar": "assets/images/berita_bmkg.png",
        "kategori": "Cuaca",
        "waktu": "5 jam lalu",
        "isi":
            "Badan Meteorologi, Klimatologi, dan Geofisika (BMKG) mengeluarkan peringatan dini terkait potensi cuaca ekstrem di sejumlah daerah. Masyarakat diimbau untuk tetap waspada terhadap kemungkinan banjir dan longsor, serta menghindari aktivitas di luar ruangan saat hujan lebat."
      },
      {
        "judul": "Mahasiswa ITENAS Raih Prestasi Nasional",
        "ringkasan":
            "Tim mahasiswa ITENAS berhasil menjuarai kompetisi Inovasi Teknologi Nasional 2025 dengan proyek Smart Farming berbasis IoT.",
        "gambar": "assets/images/berita_itenas.jpg",
        "kategori": "Pendidikan",
        "waktu": "1 hari lalu",
        "isi":
            "Tim mahasiswa ITENAS Bandung sukses meraih juara pertama dalam ajang Inovasi Teknologi Nasional 2025. Proyek yang dikembangkan berupa sistem Smart Farming berbasis IoT yang mampu memantau kelembapan tanah, suhu, dan intensitas cahaya secara real-time untuk membantu petani meningkatkan hasil panen."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // News List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: beritaList.length,
              itemBuilder: (context, index) {
                final berita = beritaList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailBeritaPage(berita: berita),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar Berita
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                            child: Stack(
                              children: [
                                Image.asset(
                                  berita["gambar"]!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[700]!,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      berita["kategori"]!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Konten Berita
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  berita["judul"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  berita["ringkasan"]!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.schedule_rounded, 
                                        size: 16, color: Colors.grey[500]),
                                    const SizedBox(width: 4),
                                    Text(
                                      berita["waktu"]!,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        "Baca Selengkapnya",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
}

class DetailBeritaPage extends StatelessWidget {
  final Map<String, String> berita;
  const DetailBeritaPage({super.key, required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar Berita
            Stack(
              children: [
                Image.asset(
                  berita["gambar"]!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Konten Berita
            Container(
              transform: Matrix4.translationValues(0, -20, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori dan Waktu
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue[700]!,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            berita["kategori"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.schedule_rounded, 
                            size: 16, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          berita["waktu"]!,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Judul
                    Text(
                      berita["judul"]!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Isi Berita
                    Text(
                      berita["isi"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}