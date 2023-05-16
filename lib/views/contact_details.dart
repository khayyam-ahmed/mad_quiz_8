import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:quiz081/models/contact.dart';
import '../models/assignment.dart';

import '../presenters/contacts_presenter.dart';

class ContactDialog {
  final teTitle = TextEditingController();
  final tedeadLine = TextEditingController();
  final teisSubmitted = TextEditingController();

  late Assignemnt contact;
  final AssignmentsPresenter assignmentsPresenter = AssignmentsPresenter();
  static const TextStyle linkStyle = TextStyle(
    decoration: TextDecoration.underline,
  );
  Widget build(
      BuildContext context, viewState, bool isEdit, Assignemnt? contact) {
    if (contact != null) {
      print(contact);

      this.contact = contact;
      teTitle.text = this.contact.title;
      tedeadLine.text = this.contact.deadLine;
      teisSubmitted.text = this.contact.isSubmitted;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Edit Assignment' : 'Add new Assignment Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Title", teTitle),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: getTextField("Deadline", tedeadLine),
              ),
            ),
            CustomSwitchWidget(
                label: "Submitted?",
                value: teisSubmitted.text == '1' ? true : false,
                onChanged: (value) {
                  teisSubmitted.text = value ? '1' : '0';
                }),
            GestureDetector(
              onTap: () async {
                await saveContact(isEdit);
                viewState.displayRecord();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    if (pickedDate != null)
      tedeadLine.text = "${pickedDate.toLocal()}".split(' ')[0];
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );
    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: const EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: const TextStyle(
          color: Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Future saveContact(bool isEdit) async {
    var contact = Assignemnt(teTitle.text, tedeadLine.text, teisSubmitted.text);

    if (isEdit && this.contact.id != null) {
      contact.setId(this.contact.id!);
    }

    return assignmentsPresenter.save(contact);
  }
}

class CustomSwitchWidget extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  CustomSwitchWidget(
      {required this.label, required this.value, this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitchWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label),
        Switch(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}
