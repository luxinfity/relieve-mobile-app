import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relieve_app/service/model/family.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

mixin Family on BaseApi {
  // families
  Future<FamilyResponse> getFamilies() async {
    var url = '$completeUri/family';
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'authorization': await pref.getToken(),
      'secret': secret,
    });

    return FamilyResponse.fromJson(jsonDecode(response.body));
  }
}
