import 'package:flutter/material.dart';

class AssignmentSummary extends InheritedWidget {
  final int submittedAssignments;
  final int pendingAssignments;
  final Widget child;

  AssignmentSummary({
    required this.submittedAssignments,
    required this.pendingAssignments,
    required this.child,
  }) : super(child: child);

  static AssignmentSummary? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AssignmentSummary>();
  }

  @override
  bool updateShouldNotify(AssignmentSummary oldWidget) {
    return pendingAssignments != oldWidget.pendingAssignments ||
        submittedAssignments != oldWidget.submittedAssignments;
  }
}
