import 'package:get/get.dart';
import '../db/db_helper.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    getTasks();
  }

  var taskList = <Task>[].obs;
  var filteredTaskList = <Task>[].obs;
  var isSearching = false.obs;
  var selectedCategory = 'All'.obs; // متغير لتخزين الفئة المحددة
  var selectedPriority = 'All'.obs; // متغير لتخزين الأولوية المحددة

  Future<int> addTask({Task? task}) async {
    return await DBHelper.instance.insert(task!);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.instance.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    filterTasks(); // تصفية المهام بعد استرجاعها من قاعدة البيانات
  }

  Future<void> delete(Task task) async {
    await DBHelper.instance.delete(task);
    getTasks(); // إعادة تحميل المهام بعد الحذف
  }

  Future<void> markTaskCompleted(int id) async {
    await DBHelper.instance.updateCompleted(id);
    getTasks(); // إعادة تحميل المهام بعد التحديث
  }

  Future<void> updateTaskInfo(Task task) async {
    await DBHelper.instance.updateTask(task);
    getTasks(); // إعادة تحميل المهام بعد التحديث
  }

  void filterTasks() {
    List<Task> tempTasks = taskList;

    // تصفية المهام بناءً على الفئة المختارة
    if (selectedCategory.value != 'All') {
      tempTasks = tempTasks
          .where((task) => task.category == selectedCategory.value)
          .toList();
    }

    // تصفية المهام بناءً على الأولوية المختارة
    if (selectedPriority.value != 'All') {
      tempTasks = tempTasks
          .where((task) => task.priority == selectedPriority.value)
          .toList();
    }

    filteredTaskList.assignAll(tempTasks); // تحديث قائمة المهام المصفاة
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      isSearching.value = false;
      filterTasks(); // إذا كانت خانة البحث فارغة، إعادة تصفية المهام
    } else {
      isSearching.value = true;
      List<Task> tempTasks = taskList.where((task) {
        // البحث في عنوان ووصف المهمة
        return task.title!.toLowerCase().contains(query.toLowerCase()) ||
            task.description!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredTaskList.assignAll(tempTasks); // تحديث قائمة المهام المصفاة بناءً على البحث
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category; // تحديث الفئة المختارة
    filterTasks(); // تصفية المهام بناءً على الفئة المختارة
  }

  void updatePriority(String priority) {
    selectedPriority.value = priority; // تحديث الأولوية المختارة
    filterTasks(); // تصفية المهام بناءً على الأولوية المختارة
  }
}
