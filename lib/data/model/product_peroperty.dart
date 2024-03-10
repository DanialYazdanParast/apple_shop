class Property {
  String? titel;
  String? value;

  Property(this.titel, this.value);

  factory Property.fromjson(Map<String, dynamic> jsonObject) {
    return Property(
       jsonObject['title'],
       jsonObject['value'],
    );
  }
}
