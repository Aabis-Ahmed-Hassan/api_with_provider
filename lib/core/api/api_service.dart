import 'dart:convert';

import 'package:api_with_provider/core/models/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_secret_key.dart';

class ApiService {
  Future<List<UserModel>> hitApi() async {
    // if no internet, return from the function
    if (!await hasInternet()) {
      throw Exception("No Internet Connection");
    }

    // hit API
    http.Response response = await http.get(Uri.parse(apiKey));
    // success
    if (response.statusCode == 200) {
      debugPrint('success');
      // json to dart
      List<dynamic> data = jsonDecode(response.body.toString());
      List<UserModel> users = [];
      // add API data into the list

      for (var i in data) {
        users.add(UserModel.fromJson(i));
      }
      return users;
    } else {
      throw Exception("Failed to load users");
    }
  }

  // check internet connectivity
  Future<bool> hasInternet() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    //   no internet
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    //   has internet connection
    else {
      return true;
    }
  }
}
