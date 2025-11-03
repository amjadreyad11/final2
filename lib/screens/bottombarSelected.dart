import 'package:final_project_dlny/screens/profile_page.dart';
import 'package:flutter/material.dart';

import 'Favorite_page.dart';
import 'chooseTheServices.dart';

class Bottombarselected extends StatefulWidget {
  const Bottombarselected({super.key});

  @override
  State<Bottombarselected> createState() => _BottombarselectedState();
}

class _BottombarselectedState extends State<Bottombarselected> {


  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Choosetheservices(userEmail: '',),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(),),

        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          selectedItemColor: Color.fromARGB(255, 250, 94, 16),
          unselectedItemColor: Colors.black38,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,

        )
    );
  }
}
