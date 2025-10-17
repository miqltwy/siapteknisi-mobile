import 'package:flutter/material.dart';
import 'pesanan.dart';

// === Custom clipper buat bikin lengkungan di atas warna merah ===
class RedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // mulai dari kiri atas
    path.lineTo(0, 0);

    // bikin lengkungan halus di atas (arah ke atas sedikit)
    path.quadraticBezierTo(
      size.width / 2, -40, // ubah -40 untuk atur tinggi lengkungan
      size.width, 0,
    );

    // terus ke bawah dan nutup
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ===== Latar belakang hijau dan merah melengkung =====
          Stack(
            children: [
              // hijau bagian atas
              Container(
                height: size.height,
                color: Colors.green,
              ),
              // merah bagian bawah dengan lengkungan
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: RedCurveClipper(),
                  child: Container(
                    height: size.height * 0.5,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

          // ===== Konten di atas background =====
          SingleChildScrollView(
            child: Column(
              children: [
                // Selamat Datang
                Container(
                  width: size.width,
                  margin: EdgeInsets.only(top: size.height * 0.1),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat\nDatang!",
                        style: TextStyle(
                          fontSize: size.width * 0.09,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        "Silakan masuk untuk\nmengakses layanan teknisi Kominfo",
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.07),

                // Kotak Login
                Container(
                  width: size.width * 0.85,
                  padding: EdgeInsets.all(size.width * 0.05),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E9DB),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email Field
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.02),
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.email_outlined, color: Colors.grey),
                            SizedBox(width: size.width * 0.02),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Masukkan email",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Password Field
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.03),
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lock_outline, color: Colors.grey),
                            SizedBox(width: size.width * 0.02),
                            const Expanded(
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Masukkan password",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Icon(Icons.visibility_off, color: Colors.grey),
                          ],
                        ),
                      ),

                      // Tombol Login
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PesananPage()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
