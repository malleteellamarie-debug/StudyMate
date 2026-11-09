import 'package:flutter/foundation.dart';
import '../models/assignment.dart';

class AssignmentProvider extends ChangeNotifier {
  final List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  Future<void> addAssignment(Assignment assignment) async {
    _assignments.add(assignment);
    notifyListeners();
  }

  void toggleComplete(String title, bool currentStatus) {
    final index = _assignments.indexWhere((a) => a.title == title);
    if (index != -1) {
      _assignments[index] = _assignments[index].copyWith(isCompleted: !currentStatus);
      notifyListeners();
    }
  }

  void deleteAssignment(String title) {
    _assignments.removeWhere((a) => a.title == title);
    notifyListeners();
  }

  int get completedCount => _assignments.where((a) => a.isCompleted).length;
  int get pendingCount => _assignments.where((a) => !a.isCompleted).length;
  
  List<Assignment> get upcomingDeadlines {
    final list = _assignments
        .where((a) => !a.isCompleted && a.deadline.isAfter(DateTime.now()))
        .toList();
    list.sort((a, b) => a.deadline.compareTo(b.deadline));
    return list;
  }
}
