import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';
import '../model/models.dart';
import 'profile_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final favs = provider.favorites;

    return Scaffold(

      body: favs.isEmpty
          ? const Center(
        child: Text(
          "لا يوجد عناصر في المفضلة بعد 😔",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favs.length,
        itemBuilder: (context, i) {
          final UserModel user = favs[i];

          ImageProvider avatar;
          if (user.image != null && user.image!.isNotEmpty) {
            if (user.image!.startsWith('http')) {
              avatar = NetworkImage(user.image!);
            } else if (File(user.image!).existsSync()) {
              avatar = FileImage(File(user.image!));
            } else {
              avatar = const AssetImage('assets/default_avatar.png');
            }
          } else {
            avatar = const AssetImage('assets/default_avatar.png');
          }

          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: avatar,
              ),
              title: Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                user.career,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  provider.removeFromFavorites(user.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تمت إزالة ${user.name} من المفضلة"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              onTap: () {
                provider.selectUser(user);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilePage(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
