class TodoModel {
  String uid;
  String docId;
  String title;
  String subtitle;
  bool isCompleted;

  TodoModel({
    this.uid = '',
    this.docId = '',
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        subtitle = json['subtitle'],
        isCompleted = json['isCompleted'],
        uid = json['uid'],
        docId = json['docId'];

  
  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'isCompleted': isCompleted,
    'uid': uid,
    'docId': docId,
  };
}