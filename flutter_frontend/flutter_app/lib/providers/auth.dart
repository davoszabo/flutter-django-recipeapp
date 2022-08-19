import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  int _userId;
  String _token;
  // DateTime _expiryDate;
  // Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  int get getUserId {
    return _userId;
  }

  String get token {
    if ( //_expiryDate != null &&
        //_expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Future<void> _authenticate(
  //     String username, String email=null, String password, String urlSegment) async {
  //   var url =
  //       'http://127.0.0.1:8000/api/$urlSegment';
  //   try {
  //     var response = await http.post(
  //       url,
  //       body: json.encode({
  //         'username': username,
  //         'email': email,
  //         'password': password,
  //       }),
  //     );
  //     final responseData = json.decode(response.body);
  //     if (responseData['errors'] != null) {
  //       throw HttpException(responseData['error']['message']);
  //     }
  //     _token = responseData['idToken'];
  //     _userId = responseData['localId'];
  //     _expiryDate = DateTime.now().add(
  //       Duration(
  //         seconds: int.parse(responseData['expiresIn']),
  //       ),
  //     );
  //     autoLogout();
  //     notifyListeners();
  //     final prefs = await SharedPreferences.getInstance();
  //     final userData = json.encode({
  //       'token': _token,
  //       'userId': _userId,
  //       'expiryDate': _expiryDate.toIso8601String()
  //     });
  //     prefs.setString('userData', userData);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> signup(String username, String email, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    var url = 'http://192.168.0.109:8000/api/auth/register';
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData["username"] != username &&
          responseData["email"] != email) {
        throw Exception();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> login(String username, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    var url = 'http://192.168.0.109:8000/api/auth/authenticate';
    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: header,
            body: json.encode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 3));
      final responseData = json.decode(response.body);
      if (responseData.toString().contains("error")) {
        throw Exception();
      }
      _userId = responseData['id'];
      _token = responseData['token'];
      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(responseData['expiresIn']),
      //   ),
      // );
      // autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'userId': _userId,
        'token': _token,
        // 'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userData', userData);
    } on TimeoutException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(seconds: 3));
      if (!prefs.containsKey('userData')) {
        return false;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, dynamic>;
      // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
      // if (expiryDate.isBefore(DateTime.now())) {
      //   return false;
      // }
      _token = extractedUserData['token'];
      _userId = extractedUserData['userId'];
      // _expiryDate = expiryDate;
      notifyListeners();
      // autoLogout();
    } on TimeoutException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }

    return true;
  }

  void logout() async {
    _token = null;
    _userId = null;
    // _expiryDate = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // void autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
