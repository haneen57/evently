class TaskModel {
  String category, title, description, id, image;
  String time;
  DateTime date;
  bool isFav;
 static const String collectionName='Events';
  TaskModel({
    required this.image,
    required this.title,
    required this.category,
    required this.description,
    required this.time,
    required this.date,
    this.id = '',
    this.isFav = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      image: json['image'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      time: json['time'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']), // assuming ISO 8601 string
      id: json['id'] ,
      isFav: json['isFav'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'category': category,
      'description': description,
      'time': time,
      'date': date.millisecondsSinceEpoch, // convert DateTime to String
      'id': id,
      'isFav': isFav,
    };
  }
}
