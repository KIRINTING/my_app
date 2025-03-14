import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/todo_controller.dart';
import 'package:my_app/models/todo_model.dart';

// ignore: must_be_immutable
class AddTodoView extends StatefulWidget {

  AddTodoView({super.key});
  TodoModel? todo;

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TodoController todoController = Get.find();

  final TextEditingController textEditingController = TextEditingController();

  final TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      textEditingController.text = widget.todo!.title;
      subtitleController.text = widget.todo!.subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มรายการที่ต้องทำ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: 'หัวข้อ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(
                labelText: 'รายละเอียด',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  todoController.addTodo(
                      textEditingController.text, subtitleController.text);
                  Get.back();
                  Get.snackbar(
                    "แจ้งแตือน",
                    "บันทึกสำเร็จ",
                    backgroundColor: Colors.white12,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}
