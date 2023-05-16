import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../models/assignment.dart';
import '../views/base_view.dart';
import '../presenters/contacts_presenter.dart';
import 'contact_details.dart';
import 'contact_list.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements BaseView {
  late AssignmentsPresenter assignmentsPresenter;

  @override
  void initState() {
    super.initState();
    assignmentsPresenter = AssignmentsPresenter.withView(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'M Haris Khan',
            ),
            Text(
              '294699',
            ),
          ],
        ),
      ],
    );
  }

  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ContactDialog().build(context, this, false, null),
    );

    screenUpdate();
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _openAddUserDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),
      body: FutureBuilder<List<Assignemnt>>(
        future: assignmentsPresenter.getAll(),
        builder: (context, snapshot) {
          return ContactList(snapshot.data ?? [], assignmentsPresenter);
        },
      ),
    );
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
