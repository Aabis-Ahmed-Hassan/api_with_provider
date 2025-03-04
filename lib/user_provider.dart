import 'dart:convert';

import 'package:api_with_provider/api_key.dart';
import 'package:api_with_provider/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  // list of users' data which we'll get from the API
  List<UserModel> _users = [];
  // show loading initially
  bool _isLoading = true;

  List<UserModel> get users => _users;

  bool get isLoading => _isLoading;

  Future<void> getUsers(BuildContext context) async {
    // if no internet, return from the function
    if (!await hasInternet()) {
      setLoading(false);
      // show error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No Internet')));
      // don't call the API if there is no internet connection
      return;
    }
    try {
      // clear the list when API call is made (again)
      _users = [];
      // hit API
      http.Response response = await http.get(Uri.parse(apiKey));
      // success
      if (response.statusCode == 200) {
        debugPrint('success');
        // json to dart
        var data = jsonDecode(response.body.toString());
        // add API data into a list
        for (var i in data) {
          users.add(UserModel.fromJson(i));
        }
        // shuffle the list so upon refreshing the screen, the user will get to know that the API is called again.
        users.shuffle();
      } else {
        debugPrint('error');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    // after the API call is made, hide the loading
    setLoading(false);
    notifyListeners();
  }

  // change the loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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
