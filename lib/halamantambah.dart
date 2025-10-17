import 'package:flutter/material.dart';

class Halamantambah extends StatelessWidget {
  const Halamantambah({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Palet warna yang match screenshot
    const bgGreen = Color(0xFFA7C1A8);   // latar belakang
    const cardCream = Color(0xFFEDEDE0); // krem kartu & isian
    const cardBorder = Color(0xFFBFC6B6); // garis tepi kartu
    const fieldBorder = Color(0xFFC7D0C1); // garis tepi field
    const buttonGreen = Color(0xFF24A31A); // tombol "SELESAI"

    return Scaffold(
      backgroundColor: bgGreen,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Tombol kembali (pill, tipis, sama seperti bg)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF819A91),

                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.white70, width: 1),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Kembali"),
              ),

              const SizedBox(height: 20),

              // Judul halaman
              const Text(
                "Buat Pesanan Baru",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 25),

              // Kartu form (krem, border abu tipis, shadow halus)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardCream,
                  border: Border.all(color: cardBorder),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Informasi Pesanan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),

                    // ===== Kategori masalah
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Kategori masalah",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: cardCream,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(color: fieldBorder, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(color: fieldBorder, width: 1.2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ===== Deskripsi
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deskripsi",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cardCream,
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: fieldBorder, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: fieldBorder, width: 1.2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Tombol SELESAI (hijau kapsul, ~70% lebar kartu)
                    SizedBox(
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: () {
                          // aksi submit
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "SELESAI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
