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
    name: 'John Peter Deloso',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'johnpeter.deloso@csucc.edu.ph',
  ),
  Student(
    name: 'Marne Betanio',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'marne.betanio@csucc.edu.ph',
  ),
  Student(
    name: 'John Russel Nakila',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'johnrussel.nakila@csucc.edu.ph',
  ),
  Student(
    name: 'Ashley Joy Pullos',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'ashleyjoy.pullos@csucc.edu.ph',
  ),
  Student(
    name: 'Jian Reiner Dablo',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'jianreiner.dablo@csucc.edu.ph',
  ),
];

// Customize: maps each year level to its own accent color (Y1 teal, Y2 orange, Y3 indigo, Y4 pink).
Color _yearLevelColor(int yearLevel) => switch (yearLevel) {
      1 => Colors.teal,
      2 => Colors.orange,
      3 => Colors.indigo,
      4 => Colors.pink,
      _ => Colors.blueGrey,
    };

// Stateless because it only shows a fixed heading; no data ever changes.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      // Customize: slightly more vertical spacing above and below the header.
      padding: const EdgeInsets.fromLTRB(4, 28, 4, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Customize: small rounded accent bar in the theme's primary color.
              Container(
                width: 6,
                height: 30,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  // Customize: larger bold title tinted with the theme's primary color.
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          // Customize: icon tinted with the theme's primary color.
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              // Customize: slightly smaller grey text style for secondary info.
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Customize: avatar and badge color is unique for each year level.
    final Color yearColor = _yearLevelColor(student.yearLevel);

    return Card(
      // Customize: rounded card corners (radius 16) with a softer, larger elevation.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      // Customize: soft tinted card background using the theme's surfaceContainerHighest color.
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
      // Customize: cards rely on the list padding for horizontal spacing, so only a bottom margin.
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        // Customize: extra horizontal padding (18) so the card content breathes.
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              // Customize: larger avatar (radius 30) tinted by year level, with a white bold initial.
              radius: 30,
              backgroundColor: yearColor,
              foregroundColor: Colors.white,
              child: Text(
                student.name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    // Customize: bolder, larger name style with slight letter spacing.
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    student.course,
                    // Customize: course shown in a muted grey tone.
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
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
            const SizedBox(width: 8),
            // Customize: rounded "Year N" badge tinted by the student's year level.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: yearColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Year ${student.yearLevel}',
                style: TextStyle(
                  color: yearColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // Customize: AppBar on the primary color with a white, bold, centered title and a school icon.
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school),
            const SizedBox(width: 8),
            const Text(
              'Campus Directory',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        // Customize: consistent padding around the whole list.
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
      debugShowCheckedModeBanner: false,
      // Customize: richer deep-purple seed color with Material 3 kept on.
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        // Customize: light lavender scaffold background so the tinted cards stand out.
        scaffoldBackgroundColor: const Color(0xFFF3F0FB),
      ),
      home: const DirectoryScreen(),
    );
  }
}

void main() => runApp(const DirectoryApp());
