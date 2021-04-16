class NotesModal {
  int _id;
  String _noteTitle;
  String _noteText;

  NotesModal({int id, String noteTitle, String noteText})
      : _id = id,
        _noteTitle = noteTitle,
        _noteText = noteText;

  int get id => _id;
  String get noteTitle => _noteTitle;
  String get noteText => _noteText;

  NotesModal.fromMap(Map<String, dynamic> data) {
    _id = data["noteId"];
    _noteTitle = data["noteTitle"];
    _noteText = data["noteText"];
  }

  Map<String, dynamic> toMap() =>
      {"noteId": _id, "noteTitle": _noteTitle, "noteText": _noteText};
}
