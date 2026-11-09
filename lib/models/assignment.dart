class Assignment {
  final String title;
  final String description;
  final DateTime deadline;
  final String subject;
  final String priority;
  final bool isCompleted;

  Assignment({
    required this.title,
    required this.description,
    required this.deadline,
    required this.subject,
    required this.priority,
    this.isCompleted = false,
  });

  Assignment copyWith({
    String? title,
    String? description,
    DateTime? deadline,
    String? subject,
    String? priority,
    bool? isCompleted,
  }) {
    return Assignment(
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      subject: subject ?? this.subject,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}