class Gender {
  final String label;

  static final Gender male = new Gender._internal("m");
  static final Gender female = new Gender._internal("f");

  factory Gender(String label) {
    if (label == 'm')
      return male;
    else if (label == "f")
      return female;
    else
      throw ArgumentError('unidentified gender');
  }

  Gender._internal(this.label);

  factory Gender.parseString(String str) {
    if (str == 'Laki - Laki')
      return male;
    else if (str == "Perempuan")
      return female;
    else
      throw ArgumentError('unidentified gender');
  }

  @override
  String toString() {
    return this == male ? "Laki - Laki" : "Perempuan";
  }
}
