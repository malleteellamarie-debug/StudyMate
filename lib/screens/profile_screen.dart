import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👤 Profile'),
        backgroundColor: const Color(0xFF6A1B9A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF6A1B9A),
              child: Text('SM',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            const Text('ELLA GONZALES',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Associate in Information Technology • 2nd Year',
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.school, color: Color(0xFF6A1B9A)),
              title: const Text('Course & Year Level'),
              subtitle: const Text('ACT - 2'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF6A1B9A)),
              title: const Text('Student Information'),
              subtitle: const Text('Edit your profile details'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF6A1B9A)),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_center, color: Color(0xFF6A1B9A)),
              title: const Text('Help & Support'),
              onTap: () {},
            ),
            const SizedBox(height: 30),
            const Text('StudyMate v1.0 📚',
                style: TextStyle(color: Colors.black38)),
          ],
        ),
      ),
    );
  }
}
