import 'package:flutter/material.dart';
import 'Favorite_page.dart';
import 'chooseTheServices.dart';
import 'profile_page.dart';

class Bottombarselected extends StatefulWidget {
  const Bottombarselected({super.key});

  @override
  State<Bottombarselected> createState() => _BottombarselectedState();
}

class _BottombarselectedState extends State<Bottombarselected> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const Choosetheservices(userEmail: ''), // الصفحة الرئيسية (الخدمات)
      const FavoritesPage(), // صفحة المفضلة
      const ProfilePage(), // صفحة الملف الشخصي
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _titles = [
    "اختيار الخدمة",
    "المفضلة ❤️",
    "الملف الشخصي 👤"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/left-arrow.png',
            width: 24,
            height: 24,
          ),
          onPressed: () { Navigator.pop(context);
          },
        ),
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 250, 94, 16),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
