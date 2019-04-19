import 'dart:_http';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relieve_app/service/model/address.dart';
import 'package:relieve_app/service/model/contact.dart';
import 'package:relieve_app/service/model/location.dart';
import 'package:relieve_app/service/model/user.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

mixin Profile on BaseApi {
  // profile
  Future<UserResponse> getUser() async {
    var url = '$completeUri/user/profile';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'authorization': await pref.getToken(),
      'secret': secret,
    });

    return UserResponse.fromJson(jsonDecode(response.body));
  }

  Future<ContactResponse> getNearbyEmergencyContact(Location location) async {
    var url = '$completeUri/emergency-contact/nearby';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'authorization': await pref.getToken(),
        'secret': secret,
      },
      body: jsonEncode({
        'coordinates': location.toString(),
        'radius': 2000,
      }),
    );

    return ContactResponse.fromJson(jsonDecode(response.body));
  }

  Future<AddressResponse> getUserAddress() async {
    var url = '$completeUri/address';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'authorization': await pref.getToken(),
      'secret': secret,
    });

    return AddressResponse.fromJson(jsonDecode(response.body));
  }
}
