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
    'Arsitektur',
    'Teknik Mesin',
    'Teknik Kimia',
    'Teknik Lingkungan',
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

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

    _showSuccessDialog('Data berhasil disimpan!');
  }

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
    _showSuccessDialog('Semua data berhasil dihapus!');
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.green[400],
          size: 50,
        ),
        title: const Text('Sukses'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Form Input
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/foto.jpg'),
                      ),
                    ),
                      const SizedBox(height: 20),
                    // Input Nama
                    _buildTextField(
                      controller: _namaController,
                      label: 'Nama Lengkap',
                      icon: Icons.person_rounded,
                    ),
                    const SizedBox(height: 15),

                    // Input Alamat
                    _buildTextField(
                      controller: _alamatController,
                      label: 'Alamat',
                      icon: Icons.home_rounded,
                    ),
                    const SizedBox(height: 15),

                    // Dropdown Jurusan
                    _buildDropdownField(),
                    const SizedBox(height: 15),

                    // Radio button Jenis Kelamin
                    _buildGenderField(),
                    const SizedBox(height: 15),

                    // Date Picker
                    _buildDateField(),
                    const SizedBox(height: 25),

                    // Tombol Aksi
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            text: 'Simpan Data',
                            icon: Icons.save_rounded,
                            color: Colors.blue[700]!,
                            onPressed: _saveData,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            text: 'Hapus Data',
                            icon: Icons.delete_rounded,
                            color: Colors.red[600]!,
                            onPressed: _resetData,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[700]!),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Jurusan',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[700]!),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      value: _selectedJurusan,
      items: _jurusanList
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedJurusan = value;
        });
      },
      icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[600]),
    );
  }

  Widget _buildGenderField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jenis Kelamin',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildGenderOption(
                  'Laki-laki',
                  Icons.male_rounded,
                  'Laki-laki',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGenderOption(
                  'Perempuan',
                  Icons.female_rounded,
                  'Perempuan',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String text, IconData icon, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedGender == value ? Colors.blue[50] : Colors.white,
          border: Border.all(
            color: _selectedGender == value
                ? Colors.blue[700]!
                : Colors.grey[300]!,
            width: _selectedGender == value ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _selectedGender == value
                  ? Colors.blue[700]
                  : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            // Make the text flexible so it can ellipsize instead of overflowing
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: _selectedGender == value
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: _selectedGender == value
                      ? Colors.blue[700]
                      : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedDate == null
                    ? 'Pilih Tanggal Lahir'
                    : '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                style: TextStyle(
                  color: _selectedDate == null
                      ? Colors.grey[500]
                      : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      icon: Icon(icon, color: Colors.white, size: 20),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
