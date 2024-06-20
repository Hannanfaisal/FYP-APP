/// _id : "660be15e9a351568b84379f1"
/// title : "title1"
/// content : "Peace talks more realistic says president, visit to Pakistan.Peace talks more realistic says president, visit to Pakistan.Peace talks more realistic says president, visit to Pakistan."
/// duration : "1 day"
/// createdAt : "2024-04-02T10:43:42.701Z"
/// updatedAt : "2024-04-02T10:43:42.701Z"
/// __v : 0
/// date : "2024-04-03T04:34:59.000Z"

class AnnouncementsModel {
  AnnouncementsModel({
      String? id, 
      String? title, 
      String? content, 
      String? duration, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      String? date,}){
    _id = id;
    _title = title;
    _content = content;
    _duration = duration;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _date = date;
}

  AnnouncementsModel.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _content = json['content'];
    _duration = json['duration'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _date = json['date'];
  }
  String? _id;
  String? _title;
  String? _content;
  String? _duration;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _date;
AnnouncementsModel copyWith({  String? id,
  String? title,
  String? content,
  String? duration,
  String? createdAt,
  String? updatedAt,
  num? v,
  String? date,
}) => AnnouncementsModel(  id: id ?? _id,
  title: title ?? _title,
  content: content ?? _content,
  duration: duration ?? _duration,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  date: date ?? _date,
);
  String? get id => _id;
  String? get title => _title;
  String? get content => _content;
  String? get duration => _duration;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['content'] = _content;
    map['duration'] = _duration;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['date'] = _date;
    return map;
  }

}