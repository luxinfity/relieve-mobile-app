import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/api/bakau/bakau_api.dart';
import 'package:relieve_app/service/api/provider.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';

class BakauProvider extends Provider implements BakauApi {
  @override
  final String name = "bakau";

  /// region Map
  @override
  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location) async {
    this.checkProvider();

    var url = '$completeUri/emergency-contact/nearby';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
//        'authorization': await PreferenceUtils.getToken(),
        'secret': secret,
      },
      body: jsonEncode({
        'coordinates': location.toString(),
        'radius': 2000,
      }),
    );

    return ContactResponse.fromJson(jsonDecode(response.body));
  }

  /// endregion

  /// wrapper of `FirestoreHelper.get().getFamilies()`
  /// because query can be done directly to fire store
  @override
  Future<List<Family>> getFamilies() async {
    return FirestoreHelper.get().getFamilies();
  }

  @override
  Future<bool> addFamily(RelieveUser other) async {
    return false;
  }

  @override
  Future<bool> confirmFamilyAuth(String code) async {
    return false;
  }
}
