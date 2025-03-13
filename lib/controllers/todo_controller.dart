import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/core/constants.dart';
import 'package:my_app/services/storage_service.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs; // รายการงานแบบ Observable
  StorageService storageService = StorageService();
  AuthController authController = Get.put(AuthController());
  

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchTodos(); // ดึงข้อมูลงานที่บันทึกไว้
  }

  Future<void> addTodo(String title, String subtitle) async {
    try {
      String? uid = authController.user.value?.uid;
      if (uid == null) return;

      TodoModel newTodo = TodoModel(uid: uid, title: title, subtitle: subtitle);
      String docId = await storageService.write(
        AppKey.todoList,
        newTodo.toJson(),
      );

      newTodo.docId = docId;
      todoList.add(newTodo);
      todoList.refresh();
    } catch (e) {
      print("TodoController.addTodo: $e");
    }
  }

  /// ✅ อัปเดตข้อมูลตาม `docId`
  Future<void> toggleTodo(
    String docId,
    bool isCompleted,
  ) async {
    try {
      TodoModel todo = todoList.firstWhere((e) => e.docId == docId);
      todo.isCompleted = isCompleted;
      await storageService.update(AppKey.todoList, docId, todo.toJson());
      todoList.refresh();
    } catch (e) {
      print('StorageService.update: $e');
    }
  }

  /// ✅ ลบข้อมูลตาม `docId`
  Future<void> deleteTodo(String docId) async {
    try {
      await storageService.delete(AppKey.todoList, docId);
      todoList.removeWhere((e) => e.docId == docId);
      todoList.refresh();
    } catch (e) {
      print('StorageService.delete: $e');
    }
  }

  Future<void> fetchTodos() async {
    var todos = await storageService.read(AppKey.todoList, uid: authController.user.value?.uid);
    todoList.value = todos.map((e) => TodoModel.fromJson(e)).toList();
  }
}