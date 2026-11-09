import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/assignment.dart';
import '../providers/assignment_provider.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _subjectController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedPriority = 'Medium';

  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Add New Assignment', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? 'Please enter a title' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? 'Please enter subject' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: const InputDecoration(labelText: 'Priority', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: 'High', child: Text('🔴 High')),
                      DropdownMenuItem(value: 'Medium', child: Text('🟡 Medium')),
                      DropdownMenuItem(value: 'Low', child: Text('🟢 Low')),
                    ],
                    onChanged: (v) => setState(() => _selectedPriority = v!),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: Text('Due Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final newAssignment = Assignment(
                          title: _titleController.text,
                          description: _descController.text,
                          deadline: _selectedDate,
                          subject: _subjectController.text,
                          priority: _selectedPriority,
                        );
                        await Provider.of<AssignmentProvider>(context, listen: false)
                            .addAssignment(newAssignment);
                        _titleController.clear();
                        _descController.clear();
                        _subjectController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A1B9A),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Save Assignment', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssignmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('✍️ Assignments'),
        backgroundColor: const Color(0xFF6A1B9A),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showAddDialog),
        ],
      ),
      body: provider.assignments.isEmpty
          ? const Center(child: Text('No assignments yet. Tap + to add one! ✏️', style: TextStyle(fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.assignments.length,
              itemBuilder: (ctx, i) {
                final a = provider.assignments[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 2,
                  child: ListTile(
                    leading: Checkbox(
                      value: a.isCompleted,
                      onChanged: (_) => provider.toggleComplete(a.title, a.isCompleted),
                    ),
                    title: Text(
                      a.title,
                      style: TextStyle(decoration: a.isCompleted ? TextDecoration.lineThrough : null),
                    ),
                    subtitle: Text('${a.subject} • Due: ${DateFormat.yMd().format(a.deadline)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => provider.deleteAssignment(a.title),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
