import 'package:relieve_app/datamodel/profile.dart';

class RelieveUser {
  final String uid;
  final Profile profile;
  final String label;

  const RelieveUser(this.uid, this.profile, {this.label});

  RelieveUser copyWith({
    final String uid,
    final Profile profile,
    final String label,
  }) {
    return RelieveUser(
      uid ?? this.uid,
      profile ?? this.profile,
      label: label ?? this.label,
    );
  }
}
