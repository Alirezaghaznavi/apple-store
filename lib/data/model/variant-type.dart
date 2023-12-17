class VariantType {
  String id;
  String name;
  String title;
  String type;
  VariantTypeEnum? typeEnum;

  VariantType(this.id, this.name, this.title, this.type, this.typeEnum);

  factory VariantType.fromJosn(Map<String, dynamic> jsonobject) {
    return VariantType(
        jsonobject['id'],
        jsonobject['name'],
        jsonobject['title'],
        jsonobject['type'],
        getVariantEnum(jsonobject['type']));
  }
}

VariantTypeEnum getVariantEnum(String type) {
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
