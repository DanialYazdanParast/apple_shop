class VarientType {
  String? id;
  String? name;
  String? titel;

  VariantTypeEnum? type;

  VarientType(this.id, this.name, this.titel, this.type);

  factory VarientType.fromJson(Map<String, dynamic> jsonObject) {
    return VarientType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getTypeEnum(
        jsonObject['type'],
      ),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.COLOR;
    case 'Storage':
      return VariantTypeEnum.STORAGE;
    case 'Voltage':
      return VariantTypeEnum.VOLTAGE;
    default:
      return VariantTypeEnum.COLOR;
  }
}

enum VariantTypeEnum { COLOR, STORAGE, VOLTAGE }
