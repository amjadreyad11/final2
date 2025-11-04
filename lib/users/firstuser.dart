import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';

class UsersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<UserProvider>(context);
    final user = provider.selectedUser;

    if (user == null) {

      return Scaffold(body: Center(child: Text("No user selected")));

    }
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(radius: 60, backgroundImage: NetworkImage(user.image)),
              SizedBox(height: 20),
              Text("Name: ${user.name}", style: TextStyle(fontSize: 20)),
              Text("Job: ${user.job}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  provider.addToFavorites(user);
                },
                child: Text("Add to Favorites"),
              ),
            ],
          ),)
    );
  }
}