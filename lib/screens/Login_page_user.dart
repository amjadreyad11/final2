import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../service/db_helper.dart';
import 'Sign_Up_page.dart';
import 'bottombarSelected.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 🔍 دالة التحقق من المستخدم
  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء إدخال البريد الإلكتروني وكلمة المرور")),
      );
      return;
    }

    final user = await DBHelper.getUserByEmail(email);

    if (user != null && user['password'] == password) {
      // ✅ تسجيل الدخول ناجح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Bottombarselected(),
        ),
      );
    } else {
      // ❌ فشل تسجيل الدخول
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("البريد الإلكتروني أو كلمة المرور غير موجودة")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Hello",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const Text(
                "Welcome back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 9, 9),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Let’s Login to Your Account",
                style: TextStyle(
                  color: Color.fromARGB(179, 12, 12, 12),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              // 📧 Email field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 8, 8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(241, 235, 235, 161),
                  hintText: "Enter your email",
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 250, 94, 16), width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 250, 94, 16), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🔒 Password field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 7, 7),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(241, 235, 235, 161),
                  hintText: "Enter your password",
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(255, 79, 79, 80),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 250, 94, 16), width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 250, 94, 16), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔘 Sign in button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login, // ← الدالة التي تحقق الدخول
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color.fromARGB(255, 250, 94, 16),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 250, 94, 16),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
