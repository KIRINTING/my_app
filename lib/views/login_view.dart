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
      appBar: AppBar(title: Text('Login')),
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
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(RegisterView());
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}