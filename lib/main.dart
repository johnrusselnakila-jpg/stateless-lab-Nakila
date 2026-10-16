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
