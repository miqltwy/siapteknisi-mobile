import 'package:flutter/material.dart';
import 'halamantambah.dart';
import 'riwayat_page.dart';
import 'notifikasi_page.dart';
import 'next_screen.dart'; // ✅ Tambahkan ini untuk navigasi ke login

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int _selectedIndex = 0;
  bool _navigating = false;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (_navigating) return;

    void safePush(Widget page) {
      setState(() => _navigating = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page))
            .whenComplete(() {
          if (mounted) setState(() => _navigating = false);
        });
      });
    }

    if (index == 1) {
      safePush(const RiwayatPage());
    } else if (index == 2) {
      safePush(const NotifikasiPage());
    } else if (index == 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                // ✅ kembali ke login dan hapus semua riwayat halaman
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const NextScreen()),
                      (route) => false,
                );
              },
              child: const Text('Ya'),
            ),
          ],
        ),
      );
    }
  }

  void _pushTambah() {
    if (_navigating) return;
    setState(() => _navigating = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Halamantambah()),
      ).whenComplete(() {
        if (!mounted) return;
        setState(() => _navigating = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profil
            Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.person, size: 35, color: Colors.white),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Mohammad Aziz"),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(thickness: 1, color: Colors.black),
            ),

            // Gambar Teknisi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg",
                      width: double.infinity,
                      height: size.width * 0.45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "PESANAN SAAT INI",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Kartu Pesanan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildTicketCard(
                    noTiket: "KMF918327",
                    chipText: "Dalam antrian",
                    chipColor: const Color(0xFF56A1DA),
                  ),
                  const SizedBox(height: 12),
                  _buildTicketCard(
                    noTiket: "KMF918327",
                    chipText: "Menunggu Persetujuan",
                    chipColor: const Color(0xFFF1C94A),
                  ),
                  const SizedBox(height: 12),
                  _buildTicketCard(
                    noTiket: "KMF918327",
                    chipText: "Menunggu Persetujuan",
                    chipColor: const Color(0xFFF1C94A),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      // Tombol Plus custom 100% seperti gambar
      floatingActionButton: Transform.translate(
        offset: const Offset(0, -25),
        transformHitTests: true,
        child: GestureDetector(
          onTap: _pushTambah,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF819A91),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Bottom Nav rata penuh tanpa notch
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF819A91),
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, "Beranda", 0),
              _buildNavItem(Icons.history, "Riwayat", 1),
              _buildNavItem(Icons.notifications, "Notifikasi", 2),
              _buildNavItem(Icons.logout, "Logout", 3),
            ],
          ),
        ),
      ),
    );
  }

  // ==== Widgets bantu ====

  Widget _buildTicketCard({
    required String noTiket,
    required String chipText,
    required Color chipColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF93AC9B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "NO. TIKET",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  noTiket,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: chipColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              chipText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool active = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: active ? Colors.white : Colors.black),
          Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
