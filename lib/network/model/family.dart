enum PersonHealth { Fine, Bad, None }

class Family {
  final String fullName;
  final String phoneNumber;
  final String imageUrl;
  final String personHealth;

  const Family({
    this.fullName,
    this.phoneNumber,
    this.imageUrl,
    this.personHealth,
  });

  String get initials =>
      fullName.toUpperCase().split(' ').map((word) => word[0]).join(' ');
}
