import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/views/register_view.dart';
import 'package:my_app/widgets/botton_hover.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false; // ตัวแปรเก็บสถานะแสดง/ซ่อนรหัสผ่าน

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // ช่องกรอก Email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // ช่องกรอก Password พร้อมไอคอนแสดงซ่อนรหัสผ่าน
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // ลืมรหัสผ่าน? และ สมัครสมาชิก
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // ฟังก์ชันสำหรับลืมรหัสผ่าน
                      },
                      icon: Icon(Icons.help_outline, size: 18),
                      label: Text("ลืมรหัสผ่าน?"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Get.to(RegisterView());
                      },
                      icon: Icon(Icons.person_add, size: 18),
                      label: Text("สมัครสมาชิก"),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // ปุ่มเข้าสู่ระบบ
                HoverButton(
                  onPressed: () async {
                    if (!GetUtils.isEmail(emailController.text)) {
                      Get.snackbar("Error", "Invalid email address");
                      return;
                    }
                    if (passwordController.text.length < 6) {
                      Get.snackbar("Error", "Password must be at least 6 characters");
                      return;
                    }
                    await authController.login(
                      emailController.text,
                      passwordController.text,
                    );
                    emailController.clear();
                    passwordController.clear();
                  },
                  bts: "เข้าสู่ระบบ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
