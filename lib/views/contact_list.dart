import 'package:madquiz8/presenters/assignment_count.dart';
import 'package:flutter/material.dart';
import '../presenters/contacts_presenter.dart';
import 'contact_details.dart';
import '../models/assignment.dart';

class ContactList extends StatelessWidget {
  late List<Assignemnt> assignments;
  late AssignmentsPresenter assignmentsPresenter;

  ContactList(
    this.assignments,
    this.assignmentsPresenter, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final submittedAssignments =
        assignments.where((c) => c.isSubmitted == "1").length;
    final pendingAssignments =
        assignments.where((c) => c.isSubmitted == "0").length;

    return AssignmentSummary(
      submittedAssignments: submittedAssignments,
      pendingAssignments: pendingAssignments,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assignments.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${assignments[index].id}. ${assignments[index].title}",
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Deadline: ${assignments[index].deadLine}",
                              ),
                            ],
                          ),
                        ),
                        Text(
                          assignments[index].isSubmitted == "1"
                              ? "Completed"
                              : "Pending",
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () => edit(assignments[index], context),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              assignmentsPresenter.delete(assignments[index]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Text(
                "Pending assignments: $pendingAssignments",
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  "Submitted assignments: $submittedAssignments",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  displayRecord() {
    assignmentsPresenter.updateScreen();
  }

  edit(Assignemnt contact, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ContactDialog().build(context, this, true, contact),
    );
    assignmentsPresenter.updateScreen();
  }

  String getInitials(Assignemnt contact) {
    String initials = "";
    if (contact.title.isNotEmpty) {
      initials = contact.title.substring(0, 1) + ".";
    }
    if (contact.deadLine.isNotEmpty) {
      initials = initials + contact.deadLine.substring(0, 1) + ".";
    }
    return initials;
  }
}
