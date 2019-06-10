import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/api/bakau/bakau_api.dart';
import 'package:relieve_app/service/api/provider.dart';
import 'package:relieve_app/service/google/base.dart';

class BakauProvider extends Provider implements BakauApi {
  @override
  final String name = "bakau";

  /// region Auth resource
  @override
  Future<bool> isUserExist(
      ProfileIdentifier checkIdentifier, String value) async {
    this.checkProvider();

    var url = '$completeUri/auth/check';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: jsonEncode({
        'param': checkIdentifier.toString().split('.')[1],
        'value': value,
      }),
    );

    throw Exception('Bakau not implemented isUserExist yet');
    // return UserCheckResponse.fromJson(jsonDecode(response.body));
  }

  @override
  Future<bool> login(String username, String password) async {
    this.checkProvider();

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

    throw Exception('Bakau not implemented login yet');
    // return TokenResponse.fromJson(jsonDecode(response.body));
  }

  /// Not Implemented
  @override
  Future<bool> googleLogin(String accessToken, String idToken) {
    throw Exception('Bakau not implemented googleLogin yet');
  }

  @override
  Future<RelieveUser> googleLoginWrap() async {
    final user = await googleSignInScope.signIn();
    final authData = await user.authentication;
    throw Exception('Bakau not implemented googleLoginWrap yet');
    // return googleLogin(user.accessToken, user.idToken);
  }

  @override
  Future<bool> logout() {
    googleSignInScope.signOut();

    throw Exception('Bakau not implemented logout yet');
  }

  @override
  Future<bool> register(Profile profile) async {
    this.checkProvider();

    var url = '$completeUri/auth/register';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: profile.toJson(),
    );

    throw Exception('Bakau not implemented register yet');
//    return TokenResponse.fromJson(jsonDecode(response.body));
  }

  /// endregion

  /// region Map resource
  @override
  Future<AddressDetailResponse> getAddressDetailOfPosition(
      Coordinate position) async {
    this.checkProvider();

    var url =
        '$completeUri/discover/address-detail?coordinates=${position.toString()}';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
//      'authorization': await PreferenceUtils.getToken(),
      'secret': secret,
    });

    return AddressDetailResponse.fromJson(jsonDecode(response.body));
  }

  /// endregion

  /// region Families resource
  @override
  Future<FamilyResponse> getFamilies() async {
    this.checkProvider();

    var url = '$completeUri/family';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
//      'authorization': await PreferenceUtils.getToken(),
      'secret': secret,
    });

    return FamilyResponse.fromJson(jsonDecode(response.body));
  }

  /// endregion

  /// region Profile resouce
  @override
  Future<ProfileResponse> getUser() async {
    this.checkProvider();

    var url = '$completeUri/user/profile';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
//      'authorization': await PreferenceUtils.getToken(),
      'secret': secret,
    });

    return ProfileResponse.fromJson(jsonDecode(response.body));
  }

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

  @override
  Future<AddressResponse> getUserAddress() async {
    this.checkProvider();

    var url = '$completeUri/address';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
//      'authorization': await PreferenceUtils.getToken(),
      'secret': secret,
    });

    return AddressResponse.fromJson(jsonDecode(response.body));
  }

  /// endregion
}
