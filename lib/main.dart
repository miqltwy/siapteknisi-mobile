import 'package:flutter/material.dart';
import 'next_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFA7C1A8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Judul atas
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Text(
              "SiapTeknis",
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Ilustrasi (gambar agak ke bawah sedikit)
          Container(
            margin: EdgeInsets.only(top: size.height * 0.09), // geser gambar ke bawah
            height: size.height * 0.4,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Image.asset(
              "lib/img/teknisi.png", // pastikan path ini benar
              fit: BoxFit.contain,
            ),
          ),

          // Teks + tombol bawah
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: const Color(0xFF819A91),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.42),
                topRight: Radius.circular(size.width * 0.42),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.09,
            ),
            child: Column(
              children: [
                Text(
                  "Teknisi Cepat\nLayanan Tepat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA7C1A8),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NextScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "LANJUTKAN",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
