import 'package:flutter/material.dart';
import '../services/Blacksmith.dart';
import '../services/Carpentry.dart';
import '../services/Painting.dart';
import '../services/Plumbing.dart';

class Choosetheservices extends StatefulWidget {
  final String userEmail;

  const Choosetheservices({super.key, required this.userEmail});

  @override
  State<Choosetheservices> createState() => _ChoosetheservicesState();
}

class _ChoosetheservicesState extends State<Choosetheservices> {
  @override
  Widget build(BuildContext context) {
    // ✅ قياسات الشاشة
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width * 0.4;
    final double cardHeight = size.width * 0.4;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Choose the service you need...",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 94, 16),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // ✅ استخدمنا Wrap بدلاً من Row لجعل العناصر تتوزع تلقائياً حسب العرض
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 30,
                  children: [
                    _buildServiceCard(
                      title: "Carpentry",
                      imagePath: "assets/image_choose/IMG_7561.JPG",
                      width: cardWidth,
                      height: cardHeight,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Carpentry(userEmail: widget.userEmail),
                          ),
                        );
                      },
                    ),
                    _buildServiceCard(
                      title: "Blacksmith",
                      imagePath: "assets/image_choose/IMG_7559.JPG",
                      width: cardWidth,
                      height: cardHeight,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Blacksmith(userEmail: widget.userEmail),
                          ),
                        );
                      },
                    ),
                    _buildServiceCard(
                      title: "Plumbing",
                      imagePath: "assets/image_choose/IMG_7560.JPG",
                      width: cardWidth,
                      height: cardHeight,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Plumbing(userEmail: widget.userEmail),
                          ),
                        );
                      },
                    ),
                    _buildServiceCard(
                      title: "Painting",
                      imagePath: "assets/image_choose/IMG_7562.JPG",
                      width: cardWidth,
                      height: cardHeight,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Painting(userEmail: widget.userEmail),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Widget بطاقة الخدمة (مرن ومناسب لجميع المقاسات)
  Widget _buildServiceCard({
    required String title,
    required String imagePath,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: const Color.fromARGB(255, 17, 14, 103), width: 4),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$title service",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
