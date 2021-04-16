class Events {
  int _id;
  String _text;
  int _year;
  int _month;
  int _day;

  Events(
      {int id, String text = "", int year = 0, int month = 0, int day = 0})
      : _id = id,
        _text = text,
        _year = year,
        _month = month,
        _day = day;

  int get id => _id;
  String get text => _text;
  int get year => _year;
  int get month => _month;
  int get day => _day;

  Events.fromMap(Map<String, dynamic> data) {
    _id = data["eventId"];
    _text = data["text"];
    _year = data["year"];
    _month = data["month"];
    _day = data["day"];
  }

  Map<String, dynamic> toMap() =>
      {"eventId": _id, "text": _text, "year": _year, "month": _month, "day": _day};
}
