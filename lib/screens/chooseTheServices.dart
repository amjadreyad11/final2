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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/left-arrow.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("اختر الخدمة"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 94, 16),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
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

              // الصف الأول (نجار وحداد)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildServiceCard(
                    title: "Carpentry",
                    imagePath: "assets/image_choose/IMG_7561.JPG",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Carpentry(userEmail: widget.userEmail),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 30),
                  _buildServiceCard(
                    title: "Blacksmith",
                    imagePath: "assets/image_choose/IMG_7559.JPG",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Blacksmith(userEmail: widget.userEmail),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // الصف الثاني (مواسرجي ودهان)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildServiceCard(
                    title: "Plumbing",
                    imagePath: "assets/image_choose/IMG_7560.JPG",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Plumbing(userEmail: widget.userEmail),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 30),
                  _buildServiceCard(
                    title: "Painting",
                    imagePath: "assets/image_choose/IMG_7562.JPG",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Painting(userEmail: widget.userEmail),
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
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color.fromARGB(255, 17, 14, 103), width: 5),
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$title service",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
