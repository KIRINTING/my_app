import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/widgets/app_text_field.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(label: 'Email', controller: emailController),
            AppTextField(label: 'Password', controller: passwordController),
            AppTextField(label: 'Confirm Password', controller: confirmPasswordController),
            ElevatedButton(
              onPressed: () {
                // validate email
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar('Error', 'Invalid email address');
                  return;
                }
                // validate password
                if (passwordController.text.length < 6) {
                  Get.snackbar('Error', 'Password must be at least 6 characters');
                  return;
                }
                // validate confirm password
                if (passwordController.text != confirmPasswordController.text) {
                  Get.snackbar('Error', 'Password does not match');
                  return;
                }

                authController.register(emailController.text, passwordController.text,);
                emailController.clear();
                passwordController.clear();
                confirmPasswordController.clear();
              },
              child: Text('Register'),
              
            ),
          ],
        ),
      ),
    );
  }
}