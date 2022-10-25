class ChoiceEntity {
  dynamic code;
  String title;

  ChoiceEntity({required this.code, required this.title});
}

class CheckBoxItem {
  dynamic code;
  String title;

  bool isChecked = false;
  CheckBoxItem(
      {required this.code, required this.title, this.isChecked = false});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['title'] = title;
    map['isChecked'] = isChecked;
    return map;
  }
}
