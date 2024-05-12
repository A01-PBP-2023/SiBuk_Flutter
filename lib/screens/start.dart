import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sibuk_mobile/screens/login.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 134, 47, 1),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Text(
              "SIBUK",
              style: GoogleFonts.playfair(
                color: Colors.white,
                fontSize: 50.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/food.png",
              
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ENHANCE YOUR IFTAR EXPERIENCE",
                  style: GoogleFonts.playfair(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  "Find the taste of the most popular iftar foods and drinks from anywhere and anytime",
                  style: GoogleFonts.arsenal(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
            ),
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 90, 123, 101)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Get Started"),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
