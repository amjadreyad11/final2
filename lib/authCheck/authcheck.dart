import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';


class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<void> loadUserData(BuildContext context, User user) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      Provider.of<UserProvider>(context, listen: false).setUser(
        id: user.uid,
        name: data['name'],
        phone: data['phone'],
        job: data['job'],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          loadUserData(context, snapshot.data!);
          return ChooseYourReasons();
        }
        return LoginScreen();
      },
    );
  }
}
