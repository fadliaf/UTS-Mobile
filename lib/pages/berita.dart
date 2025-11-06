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
        "isi":
            "Perkembangan kecerdasan buatan (AI) di Indonesia mengalami peningkatan signifikan dalam beberapa tahun terakhir. Banyak startup dan perusahaan mulai memanfaatkan teknologi AI untuk mendukung layanan pelanggan, analisis data, hingga otomasi industri. Pemerintah pun menyiapkan berbagai inisiatif untuk mempercepat adopsi AI secara nasional."
      },
      {
        "judul": "Cuaca Ekstrem Melanda Beberapa Wilayah",
        "ringkasan":
            "BMKG memperingatkan potensi hujan deras disertai angin kencang di beberapa wilayah di Indonesia selama minggu ini.",
        "gambar": "assets/images/berita_bmkg.png",
        "isi":
            "Badan Meteorologi, Klimatologi, dan Geofisika (BMKG) mengeluarkan peringatan dini terkait potensi cuaca ekstrem di sejumlah daerah. Masyarakat diimbau untuk tetap waspada terhadap kemungkinan banjir dan longsor, serta menghindari aktivitas di luar ruangan saat hujan lebat."
      },
      {
        "judul": "Mahasiswa ITENAS Raih Prestasi Nasional",
        "ringkasan":
            "Tim mahasiswa ITENAS berhasil menjuarai kompetisi Inovasi Teknologi Nasional 2025 dengan proyek Smart Farming berbasis IoT.",
        "gambar": "assets/images/berita_itenas.jpg",
        "isi":
            "Tim mahasiswa ITENAS Bandung sukses meraih juara pertama dalam ajang Inovasi Teknologi Nasional 2025. Proyek yang dikembangkan berupa sistem Smart Farming berbasis IoT yang mampu memantau kelembapan tanah, suhu, dan intensitas cahaya secara real-time untuk membantu petani meningkatkan hasil panen."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita Terkini"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          final berita = beritaList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
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
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      berita["gambar"]!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        ),
                        const SizedBox(height: 8),
                        Text(
                          berita["ringkasan"]!,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailBeritaPage(berita: berita),
                                ),
                              );
                            },
                            child: const Text(
                              "Baca Selengkapnya",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
        title: Text(berita["judul"]!),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  berita["gambar"]!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                berita["judul"]!,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                berita["isi"]!,
                style: const TextStyle(fontSize: 16, height: 1.6),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
