import 'package:flutter/material.dart';
import 'package:final_project_dlny/screens/profile_page.dart';
import '../service/db_helper.dart';
import '../services/Blacksmith.dart';
import '../services/Carpentry.dart';
import '../services/Painting.dart';
import '../services/Plumbing.dart';
import 'Login_page_user.dart';
import 'bottombarSelected.dart';


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

  // ✅ عملية التسجيل
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final existingUser =
      await DBHelper.getUserByEmail(emailController.text.trim());
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ المستخدم موجود بالفعل")),
        );
        setState(() => _loading = false);
        return;
      }

      // ✅ حفظ المستخدم في قاعدة البيانات
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
        'image':
        "https://cdn-icons-png.flaticon.com/512/149/149071.png", // صورة افتراضية
      };

      await DBHelper.insertUser(userData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ تم التسجيل بنجاح")),
      );

      // ✅ إذا كان المستخدم مقدم خدمة
      if (_showFields) {
        final career = careerController.text.trim().toLowerCase();
        final userEmail = emailController.text.trim();
        Widget nextPage;

        if (career.contains("حداد") || career.contains("blacksmith")) {
          nextPage = Blacksmith(userEmail: userEmail);
        } else if (career.contains("نجار") || career.contains("carpentry")) {
          nextPage = Carpentry(userEmail: userEmail);
        } else if (career.contains("دهان") || career.contains("painting")) {
          nextPage = Painting(userEmail: userEmail);
        } else if (career.contains("مواسرجي") || career.contains("plumbing")) {
          nextPage = Plumbing(userEmail: userEmail);
        } else {
          nextPage = const ProfilePage();
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => nextPage),
        );
      } else {
        // ✅ المستخدم العادي
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Bottombarselected()),
        );
      }
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style:
                TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          controller: nameController,
                          hint: "Enter Your User name",
                          validator: (v) => v!.isEmpty
                              ? "Please Enter Your user name"
                              : null,
                        ),
                        const SizedBox(height: 15),
                        _label("Email"),
                        _input(
                          controller: emailController,
                          hint: "Enter Your Email",
                          validator: (v) => v!.isEmpty
                              ? "Please Enter Your Email"
                              : null,
                        ),
                        const SizedBox(height: 15),
                        _label("Password"),
                        _input(
                          controller: passwordController,
                          hint: "Enter Your Password",
                          validator: (v) => v!.isEmpty
                              ? "Please Enter Your Password"
                              : null,
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
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_showFields) ...[
                          _extraField(phoneController, "Phone number"),
                          const SizedBox(height: 12),
                          _extraField(careerController, "Career"),
                          const SizedBox(height: 12),
                          _extraField(locationController, "Workplace"),
                          const SizedBox(height: 12),
                          _extraField(experienceController,
                              "Years of experience"),
                        ],
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromARGB(255, 250, 94, 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color:
                                  Color.fromARGB(255, 250, 94, 16),
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

  // 🔹 Widgets مساعدة
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

  Widget _input({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(241, 235, 235, 161),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Color.fromARGB(255, 228, 90, 26)),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Color.fromARGB(255, 15, 53, 80)),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _extraField(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(241, 235, 235, 161),
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Color.fromARGB(255, 228, 90, 26)),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Color.fromARGB(255, 15, 53, 80)),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
