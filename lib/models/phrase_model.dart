class PhraseTable {
  static const String tableName = 'phrase';

  static final List<String> values = [id, category, status, img, phrase];

  static const String id = 'id';
  static const String category = 'category';
  static const String status = 'status';
  static const String img = 'img';
  static const String phrase = 'phrase';
}

class Phrase {
  Phrase({
    required this.id,
    required this.category,
    required this.status,
    required this.img,
    required this.phrase,
  });

  final String id;
  final String category;
  final int status;
  final String img;
  final String phrase;

  @override
  String toString() => "$id - ${phrase.substring(0, 20)}";

  factory Phrase.fromJson(Map<String, dynamic> json) => Phrase(
        id: json["id"],
        category: json["category"],
        status: json["status"],
        img: json["img"],
        phrase: json["phrase"],
      );

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      PhraseTable.id: id,
      PhraseTable.category: category,
      PhraseTable.status: status,
      PhraseTable.img: img,
      PhraseTable.phrase: phrase,
    };

    return map;
  }
}
