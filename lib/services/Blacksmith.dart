import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/profile_page.dart';
import '../service/db_helper.dart';
import '../model/models.dart';
import '../provider/userprovider.dart';

class Blacksmith extends StatefulWidget {
  final String userEmail;

  const Blacksmith({super.key, required this.userEmail});

  @override
  State<Blacksmith> createState() => _BlacksmithState();
}

class _BlacksmithState extends State<Blacksmith> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBlacksmiths();
  }

  Future<void> _loadBlacksmiths() async {
    final dbUsers = await DBHelper.getUsersByJob("حداد");
    final dbUsers2 = await DBHelper.getUsersByJob("blacksmith");

    final all = [...dbUsers, ...dbUsers2];

    final List<UserModel> blacksmiths = all.map((e) => UserModel.fromMap(e)).toList();

    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.setUsers(blacksmiths);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final users = provider.users;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("خدمات الحدادة"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 94, 16),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? const Center(
        child: Text(
          "لا يوجد حدادين حالياً 😔",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final isFav = provider.favorites.any((u) => u.id == user.id);

          return GestureDetector(
            onTap: () {
              provider.selectUser(user);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // صورة المستخدم
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.image != null &&
                          user.image!.isNotEmpty
                          ? (user.image!.startsWith('http')
                          ? NetworkImage(user.image!)
                          : FileImage(
                        Uri.parse(user.image!).isAbsolute
                            ? File(user.image!)
                            : File('assets/default_avatar.png'),
                      ))
                          : const AssetImage('assets/default_avatar.png')
                      as ImageProvider,
                    ),
                    const SizedBox(width: 16),

                    // البيانات النصية
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text("📞 ${user.phone}",
                              style: const TextStyle(fontSize: 16)),
                          Text("📍 ${user.location}",
                              style: const TextStyle(fontSize: 16)),
                          Text("💼 خبرة: ${user.experience} سنة",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),

                    // زر المفضلة ❤️
                    IconButton(
                      icon: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isFav) {
                          provider.removeFromFavorites(user.id);
                        } else {
                          provider.addToFavorites(user);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
