import 'package:final_project_dlny/screens/Login_page_user.dart';
import 'package:final_project_dlny/screens/profile_page.dart';
import 'package:flutter/material.dart';

import '../service/db_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final careerController = TextEditingController();
  final locationController = TextEditingController();
  final experienceController = TextEditingController();

  bool _loading = false;
  bool _showFields = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final existingUser = await DBHelper.getUserByEmail(emailController.text.trim());
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ المستخدم موجود بالفعل")),
        );
        return;
      }

      // ✅ حفظ المستخدم في قاعدة البيانات العامة
      final userData = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'phone': phoneController.text.trim(),
        'career': careerController.text.trim(),
        'location': locationController.text.trim(),
        'experience': experienceController.text.trim(),
        'isProvider': _showFields ? 1 : 0,
        'favorite': 0,
        'image': "https://cdn-icons-png.flaticon.com/512/149/149071.png", // صورة افتراضية
      };

      await DBHelper.insertUser(userData);

      // ✅ إذا كان مقدم خدمة (Provider) أضفه إلى جدول المهنيين مباشرة
      if (_showFields) {
        print("تمت إضافة المستخدم كمقدم خدمة في مهنة: ${careerController.text}");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ تم التسجيل بنجاح")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("❌ خطأ: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

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
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(

                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        _label("User name"),
                        _input(
                          "Enter Your User name",
                          (v) =>
                              v!.isEmpty ? "Please Enter Your user name" : null,
                        ),
                        const SizedBox(height: 15),
                        _label("Enter Your Email"),
                        _input(
                          "Enter Your Email",
                          (v) => v!.isEmpty ? "Please Enter Your Email" : null,
                        ),
                        const SizedBox(height: 15),
                        _label("Password"),
                        _input(
                          "Enter Your Password",
                          (v) =>
                              v!.isEmpty ? "Please Enter Your Password" : null,
                          obscure: true,
                        ),
                        const SizedBox(height: 25),
                        _label("Confirm Your Password"),
                        _input(
                          "Enter Your Password",
                          (v) =>
                              v!.isEmpty ? "Please Enter Your Password" : null,
                          obscure: true,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showFields = !_showFields;
                            });
                          },
                          child: Text(
                            _showFields
                                ? "Hide additional fields"
                                : "If you are a service provider",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 7, 7, 7),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_showFields) ...[
                          _extraField(phoneController, "phone number"),
                          const SizedBox(height: 12),
                          _extraField(careerController,
                            "Service provider career",
                            type: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),
                          _extraField(locationController, "Workplace"),
                          const SizedBox(height: 12),
                          _extraField(experienceController,
                            "Number of years of experience",
                          ),
                        ],
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              250,
                              94,
                              16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 248, 249, 249),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do you already have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 250, 94, 16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );

  Widget _input(
    String hint,
    String? Function(String?) validator, {
    bool obscure = false,
  }) {
    return TextFormField(
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
          fillColor: Color.fromARGB(241, 235, 235, 161),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 228, 90, 26)),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 15, 53, 80)),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _extraField(
    TextEditingController c,
    String label, {
    TextInputType? type,
  }) {
    return TextField(
      controller: c,
      keyboardType: type,
      decoration: InputDecoration(
        filled: true,
           fillColor: Color.fromARGB(241, 235, 235, 161),
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 228, 90, 26)),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 15, 53, 80)),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
