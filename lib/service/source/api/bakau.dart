import "package:http/http.dart" as http;
import "package:relieve_app/app_config.dart";
import "package:relieve_app/service/model/address.dart";
import "package:relieve_app/service/model/contact.dart";
import "package:relieve_app/service/model/token.dart";
import "package:relieve_app/service/model/user.dart";
import "package:relieve_app/service/model/user_check.dart";
import "package:relieve_app/service/service.dart";
import "package:relieve_app/service/source/api/api.dart";
import "dart:io";
import "dart:convert";

import "package:relieve_app/utils/preference_utils.dart" as pref;

class BakauApi extends BaseApi {
  @override
  final String serverName = "bakau";

  BakauApi(AppConfig appConfig) : super(appConfig);

  // Auth
  Future<UserCheckResponse> checkUser(
      UserCheckIdentifier checkIdentifier, String value) async {
    var url = "$completeUri/auth/check";
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "secret": secret
      },
      body: jsonEncode({
        "param": checkIdentifier.toString(),
        "value": value,
      }),
    );

    return UserCheckResponse.fromJson(jsonDecode(response.body));
  }

  Future<TokenResponse> login(String username, String password) async {
    var url = "$completeUri/auth/login";
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "secret": secret
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    return TokenResponse.fromJson(jsonDecode(response.body));
  }

  Future<TokenResponse> register(User user) async {
    var url = "$completeUri/auth/register";
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "secret": secret
      },
      body: user.toJson(),
    );

    return TokenResponse.fromJson(jsonDecode(response.body));
  }

  // profile
  Future<UserResponse> getUser() async {
    var url = "$completeUri/user/profile";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": await pref.getToken(),
      "secret": secret,
    });

    return UserResponse.fromJson(jsonDecode(response.body));
  }

  Future<ContactResponse> getNearbyEmergencyContact(Location location) async {
    var url = "$completeUri/emergency-contact/nearby";
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": await pref.getToken(),
        "secret": secret,
      },
      body: jsonEncode({
        "coordinates": location.toString(),
        "radius": 2000,
      }),
    );

    return ContactResponse.fromJson(jsonDecode(response.body));
  }

  Future<AddressResponse> getUserAddress() async {
    var url = "$completeUri/address";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": await pref.getToken(),
      "secret": secret,
    });

    return AddressResponse.fromJson(jsonDecode(response.body));
  }
}
