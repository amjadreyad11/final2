import 'package:flutter/material.dart';
import '../service/db_helper.dart';

class Plumbing extends StatefulWidget {
  final String userEmail;

  const Plumbing({super.key, required this.userEmail});

  @override
  State<Plumbing> createState() => _PlumbingState();
}

class _PlumbingState extends State<Plumbing> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await DBHelper.getUserByEmail(widget.userEmail);
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("خدمات السباكة"),
        backgroundColor: Colors.blueAccent,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: _buildUserCard(),
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👤 الاسم: ${userData!['name']}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("📞 الهاتف: ${userData!['phone']}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("📍 الموقع: ${userData!['location']}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("💼 الخبرة: ${userData!['experience']} سنوات", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("🔧 المهنة: ${userData!['career']}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
