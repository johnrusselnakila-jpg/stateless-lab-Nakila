import 'package:flutter/material.dart';

// Lab Activity: Building a Student Directory with Stateless Widget
// Author: Nakila
//
// This entire app is stateless on purpose: the directory data is hard-coded
// and never changes while the app runs, so no StatefulWidget or setState is
// needed anywhere.

/// Immutable data model for one student.
///
/// This is not a widget, but it is still immutable like the widgets in this
/// app: every field is `final` and the `const` constructor guarantees a
/// student can never change after it is created.
class Student {
  const Student({
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });

  final String name;
  final String course;
  final int yearLevel;
  final String email;
}

/// Hard-coded sample directory data (no user input, so it can stay `const`).
const List<Student> students = <Student>[
  Student(
    name: 'Maria Santos',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'maria.santos@school.edu',
  ),
  Student(
    name: 'Juan Dela Cruz',
    course: 'BS Computer Science',
    yearLevel: 1,
    email: 'juan.delacruz@school.edu',
  ),
  Student(
    name: 'Angelica Reyes',
    course: 'BS Information Systems',
    yearLevel: 2,
    email: 'angelica.reyes@school.edu',
  ),
  Student(
    name: 'Ramon Bautista',
    course: 'BS Information Technology',
    yearLevel: 4,
    email: 'ramon.bautista@school.edu',
  ),
  Student(
    name: 'Kristine Lim',
    course: 'BS Computer Science',
    yearLevel: 3,
    email: 'kristine.lim@school.edu',
  ),
];

// Stateless because it only shows a fixed heading; no data ever changes.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

// Stateless because it just displays one fixed icon-and-text pair.
class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Stateless because it renders an immutable Student; nothing about it changes.
class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Text(student.name[0]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    student.course,
                    overflow: TextOverflow.ellipsis,
                  ),
                  InfoRow(
                    icon: Icons.school,
                    text: 'Year ${student.yearLevel}',
                  ),
                  InfoRow(
                    icon: Icons.email,
                    text: student.email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless because the directory data is const, so the screen never rebuilds differently.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Directory')),
      body: ListView(
        children: [
          const SectionHeader(title: 'Students'),
          ...students.map((student) => StudentCard(student: student)),
        ],
      ),
    );
  }
}

// Stateless because the app configuration is set once and never changes.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DirectoryScreen(),
    );
  }
}

void main() => runApp(const DirectoryApp());
