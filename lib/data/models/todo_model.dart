class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final DateTime startDate;
  final DateTime deadlineDate;
  final bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.startDate,
    required this.deadlineDate,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'deadlineDate': deadlineDate.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'Work',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      // Safely check if old data has startDate/deadline; otherwise fallback gracefully
      startDate: map['startDate'] != null
          ? DateTime.parse(map['startDate'])
          : (map['date'] != null ? DateTime.parse(map['date']) : DateTime.now()),
      deadlineDate: map['deadlineDate'] != null
          ? DateTime.parse(map['deadlineDate'])
          : DateTime.now().add(const Duration(days: 1)),
      isCompleted: map['isCompleted'] == 1 || map['isCompleted'] == true,
    );
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    DateTime? date,
    DateTime? startDate,
    DateTime? deadlineDate,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      startDate: startDate ?? this.startDate,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}