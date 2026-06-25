/// Represents a single to-do item.
class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});

  // Converts this item to a Map so it can be JSON-encoded for storage.
  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
      };

  // Rebuilds a TodoItem from a decoded JSON map.
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );
  }
}
