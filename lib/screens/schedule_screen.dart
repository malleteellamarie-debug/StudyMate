import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📅 Class Schedule'),
        backgroundColor: const Color(0xFF6A1B9A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ScheduleCard(subject: 'PATHFIT3-213', room: 'Room 105', time: '10:00 AM - 12:00 PM', day: 'Mon'),
          _ScheduleCard(subject: 'AD ELEC5', room: 'Room 104', time: '01:00 PM - 03:30 PM', day: 'Mon, Wed'),
          _ScheduleCard(subject: 'AD ELEC4', room: 'Room 104', time: '09:30 AM - 12:00 PM', day: 'Mon, Wed'),
          _ScheduleCard(subject: 'CC104', room: 'Lab 104', time: '09:30 PM - 12:00 PM', day: 'Tue, Thu'),
          _ScheduleCard(subject: 'GEC 215', room: 'Room 103', time: '05:00 AM - 08:00 PM', day: 'Tue'),
          _ScheduleCard(subject: 'CC105', room: 'Room 104', time: '01:00 PM - 03:30 PM', day: 'Mon, Wed'),
          _ScheduleCard(subject: 'AD ELEC6', room: 'Room 203', time: '09:30 AM - 12:00 PM', day: 'Mon, Wed, Fri'),
          _ScheduleCard(subject: 'GEC 214', room: 'ROOM 103', time: '09:30 PM - 12:00 PM', day: 'Tue, Thu'),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final String subject;
  final String room;
  final String time;
  final String day;

  const _ScheduleCard({required this.subject, required this.room, required this.time, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subject, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(children: [const Icon(Icons.location_on, size: 16), const SizedBox(width: 8), Text(room)]),
            const SizedBox(height: 4),
            Row(children: [const Icon(Icons.access_time, size: 16), const SizedBox(width: 8), Text(time)]),
            const SizedBox(height: 4),
            Row(children: [const Icon(Icons.calendar_view_day, size: 16), const SizedBox(width: 8), Text(day)]),
          ],
        ),
      ),
    );
  }
}