class CategoryTable {
  static const String tableName = 'category';

  static final List<String> values = [id, status, name, icon];

  static const String id = 'id';
  static const String status = 'status';
  static const String name = 'name';
  static const String icon = 'icon';
}

class Category {
  Category(
      {required this.id,
      required this.status,
      required this.name,
      required this.icon});

  final String id;
  final int status;
  final String name;
  final String icon;

  @override
  String toString() => name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        CategoryTable.id: id,
        CategoryTable.name: name,
        CategoryTable.icon: icon,
        CategoryTable.status: status
      };
}
