import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/service/api/bakau/bakau_api.dart';
import 'package:relieve_app/service/api/provider.dart';

class BakauProvider extends Provider implements BakauApi {
  @override
  final String name = "bakau";

  /// region Families resource
  @override
  Future<Family> getFamilies() async {
    this.checkProvider();

    var url = '$completeUri/family';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
//      'authorization': await PreferenceUtils.getToken(),
      'secret': secret,
    });

    throw Exception('not implemented yet');

//    return FamilyResponse.fromJson(jsonDecode(response.body));
  }

  /// endregion

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
}
