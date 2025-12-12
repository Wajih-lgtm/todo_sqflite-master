class Task {
  int? id;
  String? title;
  String? description;
  String? priority;
  String? dueDate;
  int? isCompleted;
  String? category; // تمت إضافة خاصية الفئة لتحديد نوع المهمة
  String? createdAt;

  Task({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.dueDate,
    this.isCompleted,
    this.category, // إضافة الفئة هنا
    this.createdAt,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    dueDate = json['dueDate'];
    isCompleted = json['isCompleted'];
    category = json['category']; // تعيين قيمة الفئة من JSON
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['dueDate'] = dueDate;
    data['isCompleted'] = isCompleted;
    data['category'] = category; // تضمين الفئة في البيانات عند تحويلها إلى JSON
    data['createdAt'] = createdAt;
    return data;
  }
}
