import 'package:flutter/material.dart';
import 'pesanan.dart';
import 'home_screen.dart';
import 'notifikasi_page.dart';
import 'next_screen.dart'; // ✅ tambahkan agar bisa ke halaman login
// untuk tombol "Beranda" di bottom bar

// =============== RIWAYAT ===============
class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  int _selectedIndex = 1; // tab Riwayat aktif

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PesananPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NotifikasiPage()),
      );
    } else if (index == 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                // ✅ arahkan ke login & hapus seluruh riwayat
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Pesanan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Text('Pesanan', style: TextStyle(fontSize: 12, color: Colors.black)),
            const SizedBox(height: 16),

            // === Kartu 1 ===
            _HistoryCard(
              noTiket: 'KMF982108',
              tanggal: '12 JULI 2025',
              statusText: 'SELESAI',
              statusColor: Colors.green,
              deskripsi: 'JARINGAN WIFI TIDAK BISA\nTERHUBUNG KE INTERNET',
              onDetail: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPesananPage()));
              },
            ),
            const SizedBox(height: 12),

            // === Kartu 2 ===
            _HistoryCard(
              noTiket: 'KMF982108',
              tanggal: '12 JULI 2025',
              statusText: 'DITOLAK',
              statusColor: Colors.red,
              deskripsi: 'JARINGAN WIFI TIDAK BISA\nTERHUBUNG KE INTERNET',
              onDetail: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPesananPage()));
              },
            ),
            const SizedBox(height: 12),

            // === Kartu 3 ===
            _HistoryCard(
              noTiket: 'KMF982108',
              tanggal: '12 JULI 2025',
              statusText: 'SELESAI',
              statusColor: Colors.green,
              deskripsi: 'JARINGAN WIFI TIDAK BISA\nTERHUBUNG KE INTERNET',
              onDetail: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPesananPage()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavBar(selectedIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String noTiket;
  final String tanggal;
  final String statusText;
  final Color statusColor;
  final String deskripsi;
  final VoidCallback onDetail;

  const _HistoryCard({
    Key? key,
    required this.noTiket,
    required this.tanggal,
    required this.statusText,
    required this.statusColor,
    required this.deskripsi,
    required this.onDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onDetail, // seluruh kartu klik -> Detail
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF93AC9B),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white, width: 1), // garis putih tepi kartu
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RowLabelValue(label: 'NO. TIKET', value: noTiket),
              const SizedBox(height: 6),
              _RowLabelValue(label: 'TANGGAL', value: tanggal),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _LabelBox(text: 'STATUS TERAKHIR'),
                  const Text(' :  ', style: TextStyle(color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12), // pill
                    ),
                    child: Text(
                      statusText,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LabelBox(text: 'DESKRIPSI'),
                  const Text(' :  ', style: TextStyle(color: Colors.white)),
                  Expanded(child: Text(deskripsi, style: const TextStyle(color: Colors.white))),
                ],
              ),
              const SizedBox(height: 10),
              _PressUnderlineText(
                text: 'LIHAT DETAIL',
                onTap: onDetail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============== DETAIL PESANAN ===============
class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({super.key});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  int _selectedIndex = 1;

  // >>> Diperbaiki: tambahkan navigasi bottom bar
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
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NotifikasiPage()),
      );
    } else if (index == 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                // ✅ arahkan ke login & hapus seluruh riwayat
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeaderBack(title: 'Riwayat Laporan Pesanan'),
            const SizedBox(height: 8),

            // Breadcrumb: hitam; underline hanya ketika ditekan
            Row(
              children: [
                _BreadcrumbText(
                  text: 'Pesanan',
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const RiwayatPage()),
                          (route) => false,
                    );
                  },
                ),
                const Text('  >  ', style: TextStyle(fontSize: 12, color: Colors.black)),
                const _BreadcrumbText(text: 'Detail'), // aktif, non-clickable
              ],
            ),
            const SizedBox(height: 16),

            // Kartu gabungan (border putih)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF93AC9B),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _RowLabelValue(label: 'NO. TIKET', value: 'KMF982108', width: 140),
                  const SizedBox(height: 6),
                  const _RowLabelValue(label: 'KATEGORI', value: 'JARINGAN', width: 140),
                  const SizedBox(height: 6),
                  const _RowLabelValue(label: 'TANGGAL', value: '12 JULI 2025', width: 140),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const _LabelBox(text: 'STATUS TERAKHIR', width: 140),
                      const Text(' :  ', style: TextStyle(color: Colors.white)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          'SELESAI',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const _RowLabelValue(
                    label: 'DESKRIPSI',
                    value: 'Jaringan WIFI tidak dapat terhubung ke internet',
                    width: 140,
                  ),
                  const SizedBox(height: 6),
                  const _RowLabelValue(label: 'ESTIMASI PENGERJAAN', value: '2 JAM', width: 140),
                ],
              ),
            ),
            const SizedBox(height: 10),

            _PressUnderlineText(
              text: 'LIHAT LAPORAN TEKNISI',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LaporanTeknisiPage()),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavBar(selectedIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

// =============== LAPORAN TEKNISI (FOTO 4 + PREVIEW) ===============
class LaporanTeknisiPage extends StatefulWidget {
  const LaporanTeknisiPage({super.key});

  @override
  State<LaporanTeknisiPage> createState() => _LaporanTeknisiPageState();
}

class _LaporanTeknisiPageState extends State<LaporanTeknisiPage> {
  int _selectedIndex = 1;

  // >>> Diperbaiki: tambahkan navigasi bottom bar
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
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NotifikasiPage()),
      );
    } else if (index == 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                // ✅ arahkan ke login & hapus seluruh riwayat
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

  // Contoh sumber gambar; ganti dengan link/URL asli kalau sudah ada
  final List<ImageProvider> _images = const [
    NetworkImage('https://picsum.photos/id/237/800/600'),
    NetworkImage('https://picsum.photos/id/238/800/600'),
    NetworkImage('https://picsum.photos/id/239/800/600'),
    NetworkImage('https://picsum.photos/id/240/800/600'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeaderBack(title: 'Riwayat Laporan Pesanan'),
            const SizedBox(height: 8),

            // Breadcrumb: hitam; underline saat ditekan + NAVIGASI
            Row(
              children: [
                _BreadcrumbText(
                  text: 'Pesanan',
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const RiwayatPage()),
                          (route) => false,
                    );
                  },
                ),
                const Text('  >  ', style: TextStyle(fontSize: 12, color: Colors.black)),
                _BreadcrumbText(
                  text: 'Detail',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const DetailPesananPage()),
                    );
                  },
                ),
                const Text('  >  ', style: TextStyle(fontSize: 12, color: Colors.black)),
                const _BreadcrumbText(text: 'Laporan'), // aktif
              ],
            ),
            const SizedBox(height: 16),

            // Kartu laporan (border putih) — layout persis seperti gambar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF93AC9B),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _RowLabelValue(label: 'NO. TIKET', value: 'KMF982108', width: 140),
                  const SizedBox(height: 6),
                  const _RowLabelValue(label: 'TANGGAL', value: '12 JULI 2025', width: 140),
                  const SizedBox(height: 6),
                  const _RowLabelValue(label: 'TEKNISI', value: 'AGUNG VAN BASKERVILLE', width: 140),
                  const SizedBox(height: 10),

                  const _LabelBox(text: 'FOTO', width: 140),
                  const SizedBox(height: 8),

                  // Baris 4 foto — jarak dan ukuran disamakan
                  Row(
                    children: List.generate(4, (i) {
                      return Padding(
                        padding: EdgeInsets.only(right: i == 3 ? 0 : 12),
                        child: _PhotoBox(
                          image: _images[i],
                          onTap: () => _showImagePreview(context, _images[i]),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 12),

                  const _RowLabelValue(
                    label: 'CATATAN',
                    value: 'Router rusak dan perlu diganti baru',
                    width: 140,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavBar(selectedIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }

  void _showImagePreview(BuildContext context, ImageProvider image) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.black87,
          alignment: Alignment.center,
          child: InteractiveViewer(
            minScale: 0.8,
            maxScale: 4.0,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: image,
                errorBuilder: (_, __, ___) {
                  // fallback jika asset belum ada -> tampilkan placeholder besar
                  return Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB9C7BC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.image, color: Colors.white, size: 120),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============== WIDGET UMUM ===============
class _HeaderBack extends StatelessWidget {
  final String title;
  const _HeaderBack({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(color: Color(0xFF94AE9C), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back, size: 18, color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ],
    );
  }
}

class _RowLabelValue extends StatelessWidget {
  final String label;
  final String value;
  final double width;
  const _RowLabelValue({required this.label, required this.value, this.width = 105});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelBox(text: label, width: width),
        const Text(' :  ', style: TextStyle(color: Colors.white)),
        Expanded(child: Text(value, style: const TextStyle(color: Colors.white))),
      ],
    );
  }
}

class _LabelBox extends StatelessWidget {
  final String text;
  final double width;
  const _LabelBox({required this.text, this.width = 105});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: Text(text, style: const TextStyle(color: Colors.white)));
  }
}

// === PhotoBox baru: ukuran & gaya sesuai screenshot + bisa di-tap ===
class _PhotoBox extends StatelessWidget {
  final ImageProvider? image;
  final VoidCallback? onTap;
  const _PhotoBox({this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 72,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFFB9C7BC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 1),
        ),
        alignment: Alignment.center,
        child: image == null
            ? const Icon(Icons.image, color: Colors.white, size: 28)
            : ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
            image: image!,
            width: 60,
            height: 52,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _BottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget item(IconData icon, String label, int index) {
      final active = selectedIndex == index;
      return InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: active ? Colors.white : Colors.black),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : Colors.white,
                fontSize: 12,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return BottomAppBar(
      color: const Color(0xFF819A91),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            item(Icons.home, 'Beranda', 0),
            item(Icons.history, 'Riwayat', 1),
            item(Icons.notifications, 'Notifikasi', 2),
            item(Icons.logout, 'Logout', 3),
          ],
        ),
      ),
    );
  }
}

// =============== Widgets bantu interaksi teks/link ===============
class _BreadcrumbText extends StatefulWidget {
  final String text;
  final VoidCallback? onTap; // null = non-clickable

  const _BreadcrumbText({required this.text, this.onTap});

  @override
  State<_BreadcrumbText> createState() => _BreadcrumbTextState();
}

class _BreadcrumbTextState extends State<_BreadcrumbText> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final clickable = widget.onTap != null;
    final showUnderline = clickable && _pressed;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: clickable ? (_) => setState(() => _pressed = true) : null,
      onTapUp: clickable
          ? (_) {
        setState(() => _pressed = false);
        widget.onTap!.call();
      }
          : null,
      onTapCancel: clickable ? () => setState(() => _pressed = false) : null,
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          decoration: showUnderline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Colors.black,
        ),
      ),
    );
  }
}

class _PressUnderlineText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const _PressUnderlineText({required this.text, required this.onTap});

  @override
  State<_PressUnderlineText> createState() => _PressUnderlineTextState();
}

class _PressUnderlineTextState extends State<_PressUnderlineText> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          decoration: _pressed ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Colors.white,
        ),
      ),
    );
  }
}
