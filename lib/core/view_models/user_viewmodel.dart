import 'package:api_with_provider/core/api/api_service.dart';
import 'package:api_with_provider/core/models/user_model.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier {
  // list of users' data which we'll get from the API
  List<UserModel> _users = [];
  // show loading initially
  bool _isLoading = true;

  // error message to show on the screen
  String _errorMessage = "An error occurred";
  List<UserModel> get users => _users;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;
  Future<void> getUsers() async {
    _errorMessage = "An error occurred";
    try {
      // clear the list
      _users = [];

      _users = await ApiService().hitApi();

      //   if there are no users, show the error "No Users Found"
      if (_users.isEmpty) {
        _errorMessage = "No Users Found";
      }
    } catch (e) {
      debugPrint(e.toString());
      _errorMessage = e.toString();
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
}
