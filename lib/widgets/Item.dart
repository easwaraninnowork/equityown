// lib/models/item.dart
class Item {
  String name;
  int id;

  Item({required this.name ,required this.id});

  String toJson() {
    return name.toString();
  }
}
