import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  String? _selectedJurusan;
  String? _selectedGender;
  DateTime? _selectedDate;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  final List<String> _jurusanList = [
    'Informatika',
    'Teknik Elektro',
    'Teknik Industri',
    'Teknik Sipil',
    'Desain Produk',
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // 🔹 Ambil data tersimpan saat aplikasi dibuka
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaController.text = prefs.getString('nama') ?? '';
      _alamatController.text = prefs.getString('alamat') ?? '';
      _selectedJurusan = prefs.getString('jurusan');
      if (_selectedJurusan == '') _selectedJurusan = null;
      _selectedGender = prefs.getString('gender');
      final dateString = prefs.getString('tanggal');
      if (dateString != null) {
        _selectedDate = DateTime.tryParse(dateString);
      }
    });
  }

  // 🔹 Simpan data ke local storage
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', _namaController.text);
    await prefs.setString('alamat', _alamatController.text);
    if (_selectedJurusan != null) {
      await prefs.setString('jurusan', _selectedJurusan!);
    }
    await prefs.setString('gender', _selectedGender ?? '');
    if (_selectedDate != null) {
      await prefs.setString('tanggal', _selectedDate!.toIso8601String());
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil disimpan!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // 🔹 Hapus semua data (reset)
  Future<void> _resetData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _namaController.clear();
      _alamatController.clear();
      _selectedJurusan = null;
      _selectedGender = null;
      _selectedDate = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Semua data berhasil dihapus!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // 🔹 Pilih tanggal lahir
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Foto profil
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/foto.jpg'),
            ),
            const SizedBox(height: 16),

            const Text(
              'Biodata Mahasiswa',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1, height: 30),

            // Input Nama
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),

            // Input Alamat
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: 15),

            // Dropdown Jurusan
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Jurusan',
                border: OutlineInputBorder(),
              ),
              initialValue: _selectedJurusan,
              items: _jurusanList
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedJurusan = value;
                });
              },
            ),
            const SizedBox(height: 15),

            // Radio button Jenis Kelamin
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jenis Kelamin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RadioListTile<String>(
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Date Picker
            InkWell(
              onTap: () => _pickDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Pilih tanggal'
                      : '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 🔘 Tombol SIMPAN
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Simpan',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: _saveData,
            ),
            const SizedBox(height: 10),

            // 🔘 Tombol HAPUS
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              ),
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text(
                'Hapus Data',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: _resetData,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
