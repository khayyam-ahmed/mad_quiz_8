import 'dart:async';

import '../views/base_view.dart';
import '../models/assignment.dart';
import '../data/database_helper.dart';

class AssignmentsPresenter {
  late final BaseView _view;

  AssignmentsPresenter();
  AssignmentsPresenter.withView(this._view);
  Future<List<Assignemnt>> getAll() async {
    List<Map> list = await DatabaseHelper.internal().query("quiz");
    List<Assignemnt> contacts = [];

    for (int i = 0; i < list.length; i++) {
      contacts.add(Assignemnt.map(list[i]));
    }

    return contacts;
  }

  save(Assignemnt contact) async {
    if (contact.id != null) {
      return DatabaseHelper.internal().update("quiz", contact);
    }
    return DatabaseHelper.internal().insert("quiz", contact);
  }

  delete(Assignemnt contact) async {
    print(contact.id);
    await DatabaseHelper.internal().delete("quiz", contact);
    updateScreen();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}
