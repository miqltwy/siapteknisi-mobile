import 'package:flutter/material.dart';
import 'riwayat_page.dart';
import 'notifikasi_page.dart';
import 'halamantambah.dart';// buka halaman notifikasi

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),

      body: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 25,
              child: const Icon(Icons.person, size: 30, color: Colors.black),
            ),
            title: const Text("Selamat Datang", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Mohammad Aziz"),
          ),
          const Divider(),
          SizedBox(height: size.height * 0.02),

          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(image: AssetImage("assets/teknisi.png"), height: 120),
                Text("PESANAN SAAT INI", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Center(child: Text("BELUM ADA PESANAN")),
              ],
            ),
          ),

          const Spacer(),

          // FAB opsional (bisa diarahkan ke Halamantambah)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const Halamantambah()));
                },
                backgroundColor: Colors.grey[700],
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ),
        ],
      ),

      // bottom bar diletakkan di properti bottomNavigationBar agar tap terdeteksi
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Colors.grey[300],
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ItemNav(
                  icon: Icons.home,
                  label: 'Beranda',
                  onTap: () {
                    // sudah di Home
                  },
                ),
                _ItemNav(
                  icon: Icons.history,
                  label: 'Riwayat',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RiwayatPage()),
                    );
                  },
                ),
                _ItemNav(
                  icon: Icons.notifications,
                  label: 'Notifikasi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotifikasiPage()),
                    );
                  },
                ),
                _ItemNav(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Yakin ingin keluar?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);      // tutup dialog
                              Navigator.pop(context);  // balik 1 halaman (atau arahkan ke login)
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemNav extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ItemNav({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(color: Colors.black, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
