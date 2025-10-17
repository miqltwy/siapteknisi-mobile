import 'package:flutter/material.dart';
import 'pesanan.dart';
import 'riwayat_page.dart';
import 'halamantambah.dart';
import 'next_screen.dart'; // ✅ tambahkan import ini

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

// Model data sederhana
class _NotifItem {
  final String role;
  final String name;
  final String subtitle;
  _NotifItem({
    required this.role,
    required this.name,
    required this.subtitle,
  });
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  int _selectedIndex = 2;

  final List<_NotifItem> _terbaru = [
    _NotifItem(
      role: 'Teknisi',
      name: 'Douglas Arifin',
      subtitle: 'Laporan hasil perbaikan dari teknisi',
    ),
    _NotifItem(
      role: 'Admin',
      name: 'Admin Kominfo',
      subtitle: 'Estimasi perbaikan jaringan',
    ),
    _NotifItem(
      role: 'Teknisi',
      name: 'Douglas Arifin',
      subtitle: 'Laporan hasil perbaikan dari teknisi',
    ),
  ];

  final List<_NotifItem> _dibaca = [
    _NotifItem(
      role: 'Teknisi',
      name: 'Douglas Arifin',
      subtitle: 'Laporan hasil perbaikan dari teknisi',
    ),
  ];

  // ==== NAVIGASI BOTTOM BAR ====
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PesananPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RiwayatPage()),
      );
    } else if (index == 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // tutup dialog
                // 🔥 langsung arahkan ke halaman login dan hapus semua halaman sebelumnya
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

  // ==== FORMAT TANGGAL / JAM ====
  String _formatNow() {
    final now = DateTime.now();
    const hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const bulan = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    final namaHari = hari[(now.weekday - 1) % 7];
    final namaBulan = bulan[now.month - 1];
    String two(int n) => n < 10 ? '0$n' : '$n';
    final jam = '${two(now.hour)}:${two(now.minute)}';
    return '$namaHari, ${two(now.day)} $namaBulan ${now.year} • $jam WIB';
  }

  // ==== POPUP DETAIL NOTIF ====
  Future<void> _showDetailCard(_NotifItem item, {bool alreadyRead = false}) async {
    final waktu = _formatNow();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        const cardColor = Color(0xFF819A91);
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(ctx).size.width * 0.88,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.black,
                        child: Text(
                          item.role,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                )),
                            const SizedBox(height: 2),
                            Text(
                              item.role,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        waktu,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black.withOpacity(0.12),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTapTerbaru(int index) async {
    final item = _terbaru[index];
    await _showDetailCard(item, alreadyRead: false);
    setState(() {
      _terbaru.removeAt(index);
      _dibaca.insert(0, item);
    });
  }

  void _onTapSudahDibaca(int index) {
    final item = _dibaca[index];
    _showDetailCard(item, alreadyRead: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notifikasi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            const Text('Terbaru', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),

            for (int i = 0; i < _terbaru.length; i++) ...[
              _NotifTile(
                role: _terbaru[i].role,
                name: _terbaru[i].name,
                subtitle: _terbaru[i].subtitle,
                isRead: false,
                onTap: () => _onTapTerbaru(i),
              ),
              const SizedBox(height: 12),
            ],

            const SizedBox(height: 18),
            const Text('Sudah dibaca', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),

            for (int i = 0; i < _dibaca.length; i++) ...[
              _NotifTile(
                role: _dibaca[i].role,
                name: _dibaca[i].name,
                subtitle: _dibaca[i].subtitle,
                isRead: true,
                onTap: () => _onTapSudahDibaca(i),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF819A91),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 'Beranda', 0),
              _buildNavItem(Icons.history, 'Riwayat', 1),
              _buildNavItem(Icons.notifications, 'Notifikasi', 2),
              _buildNavItem(Icons.logout, 'Logout', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final active = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

// ================== TILE NOTIF ==================
class _NotifTile extends StatelessWidget {
  final String role;
  final String name;
  final String subtitle;
  final bool isRead;
  final VoidCallback? onTap;

  const _NotifTile({
    required this.role,
    required this.name,
    required this.subtitle,
    required this.isRead,
    this.onTap,
  });

  String _formatNowTile() {
    final now = DateTime.now();
    const hari = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    const bulan = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    String two(int n) => n < 10 ? '0$n' : '$n';
    final h = hari[(now.weekday - 1) % 7];
    final b = bulan[now.month - 1];
    final jam = '${two(now.hour)}:${two(now.minute)}';
    return '$h, ${two(now.day)} $b ${now.year} · $jam';
  }

  @override
  Widget build(BuildContext context) {
    final waktuKecil = _formatNowTile();
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF819A91),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white24,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  role,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        waktuKecil,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
