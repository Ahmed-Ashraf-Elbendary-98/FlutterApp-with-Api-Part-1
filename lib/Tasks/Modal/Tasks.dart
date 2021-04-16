class TasksModal {
  int _id;
  String _textTask;
  String _dateTask;
  int _compeleteTask;

  TasksModal({int id, String textTask, String dateTask, int compeleteTask})
      : _id = id,
        _textTask = textTask,
        _dateTask = dateTask,
        _compeleteTask = compeleteTask;

  int get id => _id;
  String get textTask => _textTask;
  String get dateTask => _dateTask;
  int get compeleteTask => _compeleteTask;

  TasksModal.fromMap(Map<String, dynamic> data) {
    _id = data["taskId"];
    _textTask = data["textTask"];
    _dateTask = data["dateTask"];
    _compeleteTask = data["compeleteTask"];
  }

  Map<String, dynamic> toMap() =>
      {"taskId": _id, "textTask": _textTask, "dateTask": _dateTask,"compeleteTask":_compeleteTask};
}
