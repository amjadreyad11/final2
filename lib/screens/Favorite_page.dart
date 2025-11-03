import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userprovider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final favs = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: ListView.builder(
        itemCount: favs.length,
        itemBuilder: (context, i) {
          final user = favs[i];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
            title: Text(user.name),
            subtitle: Text(user.job),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                provider.removeFromFavorites(user.id);
              },
            ),
          );
        },
      ),
    );
  }
}
