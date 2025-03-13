import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_app/views/home_view.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // สร้างตัวแปร Rxn<User> เพื่อติดตามสถานะของ User (Reactive Variable)
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // ฟังก์ชันนี้จะทำให้ user สามารถติดตามการเปลี่ยนแปลงของสถานะการล็อกอินได้
    user.bindStream(_auth.authStateChanges());
  }

  // 🟢 ฟังก์ชันสมัครสมาชิก
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("สำเร็จ", "สมัครสมาชิกสำเร็จ");
    } catch (e) {
      Get.snackbar("ผิดพลาด", e.toString());
    }
  }

  // 🟢 ฟังก์ชันล็อกอิน
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("สำเร็จ", "ล็อกอินสำเร็จ");
      Get.offAll(HomeView());
    } catch (e) {
      Get.snackbar("ผิดพลาด", e.toString());
    }
  }
}