import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/assignment_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssignmentProvider>(context);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 StudyMate'),
        backgroundColor: const Color(0xFF6A1B9A),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              DateFormat('MMM d, yyyy').format(now),
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome! 👋', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      Text('Ready to ace your studies today? Stay organized with StudyMate!',
                          style: TextStyle(fontSize: 16, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Completed', provider.completedCount.toString(), Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Pending', provider.pendingCount.toString(), Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(' Upcoming Deadlines', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              provider.upcomingDeadlines.isEmpty
                  ? const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('No upcoming deadlines! ', style: TextStyle(fontSize: 16)),
                      ),
                    )
                  : Column(
                      children: provider.upcomingDeadlines
                          .take(3)
                          .map((a) => Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  title: Text(a.title),
                                  subtitle: Text('${a.subject} • Due: ${DateFormat.MMMd().format(a.deadline)}'),
                                  leading: _buildPriorityBadge(a.priority),
                                ),
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    if (priority == 'High') {
      color = Colors.red;
    } else if (priority == 'Medium') {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }
    return CircleAvatar(backgroundColor: color, radius: 6);
  }
}