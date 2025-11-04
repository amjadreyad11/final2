import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../service/db_helper.dart';
import 'Assistant_evaluation.dart';
import 'Login_page_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? currentUser;
  File? _imageFile;

  final _formKey = GlobalKey<FormState>();

  // الحقول القابلة للتحرير
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final users = await DBHelper.getAllUsers();
    if (users.isNotEmpty) {
      setState(() {
        currentUser = users.last;
        _nameController.text = currentUser!['name'] ?? '';
        _phoneController.text = currentUser!['phone'] ?? '';
        _careerController.text = currentUser!['career'] ?? '';
        _locationController.text = currentUser!['location'] ?? '';
        _experienceController.text = currentUser!['experience'] ?? '';
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && currentUser != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
      });

      final updatedUser = Map<String, dynamic>.from(currentUser!);
      updatedUser['image'] = pickedFile.path;
      await DBHelper.updateUser(updatedUser);

      setState(() {
        currentUser = updatedUser;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ تم تحديث الصورة بنجاح")),
      );
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedUser = Map<String, dynamic>.from(currentUser!);
    updatedUser['name'] = _nameController.text;
    updatedUser['phone'] = _phoneController.text;
    updatedUser['career'] = _careerController.text;
    updatedUser['location'] = _locationController.text;
    updatedUser['experience'] = _experienceController.text;

    await DBHelper.updateUser(updatedUser);

    setState(() {
      currentUser = updatedUser;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ تم حفظ التعديلات بنجاح")),
    );
  }

  Future<void> _deleteAccount() async {
    if (currentUser == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("⚠️ تأكيد الحذف"),
        content: const Text("هل أنت متأكد أنك تريد حذف الحساب نهائيًا؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("نعم، حذف"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DBHelper.deleteUser(currentUser!['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🗑️ تم حذف الحساب بنجاح")),
      );

      // العودة إلى صفحة تسجيل الدخول
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (currentUser!['image'] != null &&
                      currentUser!['image'].toString().isNotEmpty)
                      ? (currentUser!['image'].toString().startsWith('http')
                      ? NetworkImage(currentUser!['image'])
                      : FileImage(File(currentUser!['image'])))
                      : const AssetImage('assets/default_avatar.png')
                  as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("الاسم", _nameController, Icons.person),
              _buildTextField("الهاتف", _phoneController, Icons.phone),
              _buildTextField("المهنة", _careerController, Icons.work),
              _buildTextField("الموقع", _locationController, Icons.location_on),
              _buildTextField("الخبرة", _experienceController, Icons.badge),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text("حفظ التغييرات"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 25),


              ElevatedButton(


onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AssistantEvaluation()),
                  );
                },

                                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                    const Color.fromARGB(255, 250, 94, 16),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                  ),

                  child: const Text(
                    "تقييم المساعد",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),




              ElevatedButton.icon(
                onPressed: _deleteAccount,
                icon: const Icon(Icons.delete_forever),
                label: const Text("حذف الحساب نهائيًا"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: (value) =>
        value == null || value.isEmpty ? "الرجاء إدخال $label" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );

  }



  Widget botton1(BuildContext context, String name) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
      child: Text(
        name,
        style: const TextStyle(
          color: Color.fromARGB(255, 250, 94, 16),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

}


