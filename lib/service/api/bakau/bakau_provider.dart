import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/api/bakau/bakau_api.dart';
import 'package:relieve_app/service/api/base/provider.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

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
        'authorization': await PreferenceUtils.get().getIdToken(),
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
  /// so didn't need to run `this.checkProvider()`;
  @override
  Future<List<Family>> getFamilies() async {
    return FirestoreHelper.get().getFamilies();
  }

  /// send request to BE
  @override
  Future<AddFamilyState> addFamily(RelieveUser other) async {
    this.checkProvider();
    var url = '$completeUri/families/add';

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'authorization': await PreferenceUtils.get().getIdToken(),
          'secret': secret,
        },
        body: jsonEncode({'uid': other.uid}),
      );

      final parsed = AddFamilyResponse.fromJson(jsonDecode(response.body));
      return parsed.content;
    } catch (error) {
      debugLog(BakauProvider).shout(error);
    }
    return AddFamilyState.CANCELED;
  }

  @override
  Future<bool> editFamilyLabel(RelieveUser other, String label) async {
    // TODO: implement edit label
    return false;
  }

  @override
  Future<AddFamilyState> confirmFamilyAuth(String code) async {
    this.checkProvider();
    return AddFamilyState.CANCELED;
  }
}
