import 'package:flutter/material.dart';

import '../services/Blacksmith.dart';
import '../services/Carpentry.dart';
import '../services/Painting.dart';
import '../services/Plumbing.dart';

class Choosetheservices extends StatefulWidget {
  const Choosetheservices({super.key});

  @override
  State<Choosetheservices> createState() => _ChoosetheservicesState();
}

class _ChoosetheservicesState extends State<Choosetheservices> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            Text(
              "Choose the service you need...",
              
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 250, 94, 16)),
            ),
            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Carpentry()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 17, 14, 103),
                              width: 15),
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/image_choose/IMG_7561.JPG"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Carpentry service",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),),
                    ],
                  ),
                ),

                const SizedBox(width: 50),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Blacksmith()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 17, 14, 103),
                              width: 15),
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/image_choose/IMG_7559.JPG"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Blacksmith service",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Plumbing()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 17, 14,103),
                              width: 15),
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/image_choose/IMG_7560.JPG"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Plumbing services",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ],
                  ),
                ),

                const SizedBox(width: 50),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Painting()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 17, 14, 103),
                              width: 15),
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/image_choose/IMG_7562.JPG"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Painting services",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
