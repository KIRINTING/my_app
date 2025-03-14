import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/models/todo_model.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_tile.dart';
import 'add_todo_view.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
          backgroundColor: Colors.black12,
          actions: [
            IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: Icon(Icons.logout),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home', icon: Icon(Icons.home)),
              Tab(text: 'Store', icon: Icon(Icons.store)),
              Tab(text: 'User Info', icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildHomeTab(),
            buildStoreTab(),
            buildUserInfoTab(),
          ],
        ),
      ),
    );
  }

  Widget buildHomeTab() {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            TodoModel todo = todoController.todoList[index];
            return TodoTile(
              todo: todoController.todoList[index],
              title: Text(todo.title),
              subtitle: Text(todo.subtitle),
              onToggle: () => todoController.toggleTodo(
                todo.docId,
                !todo.isCompleted,
              ),
              onDelete: () {
                todoController.deleteTodo(todo.docId);
                Get.snackbar(
                  'Deleted',
                  'Deleted "${todo.title}"',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              onTap: () {
                Get.to(() => AddTodoView(todo: todo));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTodoView()), // ไปหน้าเพิ่มรายการ
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildStoreTab() {
    return Center(
      child: Text('Store Page'),
    );
  }

  Widget buildUserInfoTab() {
    return Center(
      child: Text('User Info Page'),
    );
  }
}
