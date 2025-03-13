class TodoModel {
  String uid;
  String docId;
  String title;
  bool isCompleted;

  TodoModel({
    this.uid = '',
    this.docId = '',
    required this.title, 
    this.isCompleted = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isCompleted = json['isCompleted'],
        uid = json['uid'],
        docId = json['docId'];
  
  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
    'uid': uid,
    'docId': docId,
  };
}