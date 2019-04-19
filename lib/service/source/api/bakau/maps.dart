import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relieve_app/service/model/address.dart';
import 'package:relieve_app/service/model/location.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

mixin Maps on BaseApi {
  Future<AddressDetailResponse> getAddressDetailOfPosition(
      Location position) async {
    var url = '$completeUri/discover/address-detail?coordinates=${position.toString()}';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'authorization': await pref.getToken(),
      'secret': secret,
    });

    return AddressDetailResponse.fromJson(jsonDecode(response.body));
  }
}
