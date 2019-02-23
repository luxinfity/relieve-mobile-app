import 'package:http/http.dart' as http;
import 'package:relieve_app/service/model/address.dart';
import 'dart:io';
import 'dart:convert';

import '../api/config.dart';
import '../../../app_config.dart';
import '../../model/token.dart';
import '../../model/user.dart';
import '../../model/contact.dart';
import '../location.dart';
import '../../../utils/preference_utils.dart' as pref;

class BakauApi extends BaseApi {
  @override
  final String serverName = 'bakau';

  BakauApi(AppConfig appConfig) : super(appConfig);

  Future<TokenResponse> login(String username, String password) async {
    var url = '$completeUri/auth/login';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    return TokenResponse.fromJson(jsonDecode(response.body));
  }

  Future<TokenResponse> register(User user) async {
    var url = '$completeUri/auth/register';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: user.toJson(),
    );

    return TokenResponse.fromJson(jsonDecode(response.body));
  }

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
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'authorization': await pref.getToken(),
        'secret': secret,
      }
    );

    return AddressResponse.fromJson(jsonDecode(response.body));
  }
}
