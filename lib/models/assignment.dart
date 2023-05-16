import 'base_model.dart';

class Assignemnt extends BaseModel {
  late String _title;
  late String _deadLine;
  late String _isSubmitted;

  Assignemnt(
    this._title,
    this._deadLine,
    this._isSubmitted,
  );
  Assignemnt.map(dynamic obj) {
    setId(obj["id"]);
    this._title = obj['title'];
    this._deadLine = obj['deadLine'];
    this._isSubmitted = obj['isSubmitted'].toString();
  }
  String get title => _title;
  String get deadLine => _deadLine;
  String get isSubmitted => _isSubmitted;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': _title,
      'deadLine': _deadLine,
      'isSubmitted': _isSubmitted,
    };

    return map;
  }
}
