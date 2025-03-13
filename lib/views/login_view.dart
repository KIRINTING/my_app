import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/views/register_view.dart';
import 'package:my_app/widgets/app_text_field.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN'),
        ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(label: 'Email', controller: emailController),
            AppTextField(label: 'Password', controller: passwordController),
            ElevatedButton(
              onPressed: () async {
                // validate email
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar('Error', 'Invalid email address');
                  return;
                }
                // validate password
                if (passwordController.text.length < 6) {
                  Get.snackbar(
                    'Error',
                    'Password must be at least 6 characters',
                  );
                  return;
                }
                await authController.login(
                  emailController.text,
                  passwordController.text,
                );
                emailController.clear();
                passwordController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,  // สีปกติของปุ่ม
                foregroundColor: Colors.white,    // สีข้อความ
                shadowColor: Colors.white10,      // เงาของปุ่ม
                elevation: 4,                     // ยกปุ่มขึ้นให้ดูเด่น
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // ทำให้ขอบมน
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blueAccent.withOpacity(0.2); // เปลี่ยนสีพื้นหลังเมื่อ hover
                  }
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blueAccent.withOpacity(0.4); // เปลี่ยนสีเมื่อคลิก
                  }
                  return null;
                }),
              ),
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(RegisterView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,  // สีปกติของปุ่ม
                foregroundColor: Colors.white,    // สีข้อความ
                shadowColor: Colors.white10,      // เงาของปุ่ม
                elevation: 4,                     // ยกปุ่มขึ้นให้ดูเด่น
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // ทำให้ขอบมน
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blueAccent.withOpacity(0.2); // เปลี่ยนสีพื้นหลังเมื่อ hover
                  }
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blueAccent.withOpacity(0.4); // เปลี่ยนสีเมื่อคลิก
                  }
                  return null;
                }),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}