import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/region.dart';
import '../models/request/address.dart';
import 'urls.dart';

class Auth with ChangeNotifier {
  String _token;
  bool _isLoggedin;

  bool _isFirstLogin = false;
  bool _isFirstLogout = false;

//  List<Address> _addressItems = [];

//  Address _selectedAddress;

//  List<Region> _regionItems = [];

//  Region _regionData;

  bool _isCompleted = false;

  bool get isLoggedin => _isLoggedin;

  bool get isFirstLogout => _isFirstLogout;

  set isFirstLogout(bool value) {
    _isFirstLogout = value;
  }

  set isLoggedin(bool value) {
    _isLoggedin = value;
  }

  bool get isAuth {
    getToken();
    return _token != null && _token != '';
  }

  String get token => _token;
  Map<String, String> headers = {};

  Future<bool> _authenticate(String urlSegment) async {
    print('_authenticate');

    final url = Urls.rootUrl + Urls.loginEndPoint + urlSegment;
    print(url);

    try {
      final response = await http.post(url, headers: headers);
      updateCookie(response);

      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData != 'false') {
        try {
          _token = responseData['token'];
          _isFirstLogin = true;

          final prefs = await SharedPreferences.getInstance();
          final userData = json.encode(
            {
              'token': _token,
            },
          );
          prefs.setString('userData', userData);
          prefs.setString('token', _token);
          print(_token);
          prefs.setString('isLogin', 'true');
          _isLoggedin = true;
        } catch (error) {
          _isLoggedin = false;

          _token = '';
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        _isLoggedin = false;

        _token = '';
        prefs.setString('token', _token);
        print(_token);
        print('noooo token');
        prefs.setString('isLogin', 'true');
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
    return _isLoggedin;
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<void> login(String phoneNumber) async {
    return _authenticate('/send_sms?mobile=$phoneNumber');
  }

  Future<bool> getVerCode(String verificationCode, String phoneNumber) async {
    return _authenticate(
        '/verify?type=operator&mobile=$phoneNumber&sms=$verificationCode');
  }

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    notifyListeners();
  }

  Future<void> checkCompleted() async {
    try {
      if (isAuth) {
        final prefs = await SharedPreferences.getInstance();
        _token = prefs.getString('token');

        final url = Urls.rootUrl + Urls.checkCompletedEndPoint;

        final response = await get(
          url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
        );

        final extractedData = json.decode(response.body) as dynamic;

        print(extractedData.toString());
        bool isCompleted = extractedData['complete'];

        _isCompleted = isCompleted;
      } else {
        _isCompleted = false;
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }

    notifyListeners();
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _token = '';
    print('toookeeen');
    print(prefs.getString('token'));
    notifyListeners();
  }

  bool get isCompleted => _isCompleted;

  bool get isFirstLogin => _isFirstLogin;

  set isFirstLogin(bool value) {
    _isFirstLogin = value;
  }

//  Future<void> getAddresses() async {
//    print('getAddresses');
//    try {
//      if (isAuth) {
//        final prefs = await SharedPreferences.getInstance();
//        _token = prefs.getString('token');
//
//        final url = Urls.rootUrl + Urls.addressEndPoint;
//
//        final response = await get(
//          url,
//          headers: {
//            'Authorization': 'Bearer $_token',
//            'Content-Type': 'application/json',
//            'Accept': 'application/json'
//          },
//        );
//
//        final extractedData = json.decode(response.body);
//
//        print(extractedData.toString());
//        AddressMain addressMain = AddressMain.fromJson(extractedData);
//        print(extractedData.toString());
//
//        List<Address> addresseList = addressMain.addressData;
//        print('sssssssssssssssssssssssssss ${addresseList.length}');
//
//        _addressItems = addresseList;
//      } else {
//        _addressItems = [];
//      }
//      notifyListeners();
//    } catch (error) {
//      print(error.toString());
//      throw (error);
//    }
//  }
//
//  Future<void> updateAddress(List<Address> addressList) async {
//    print('addAddress');
//    try {
//      if (isAuth) {
//        final prefs = await SharedPreferences.getInstance();
//        _token = prefs.getString('token');
//        print('tooookkkkeeennnn    $_token');
//
//        final url = Urls.rootUrl + Urls.addressEndPoint;
//        print('url  $url');
//        print(jsonEncode(AddressMain(
//          addressData: addressList,
//        )));
//
//        final response = await post(url,
//            headers: {
//              'Authorization': 'Bearer $_token',
//              'Content-Type': 'application/json',
//              'Accept': 'application/json'
//            },
//            body: jsonEncode(AddressMain(
//              addressData: addressList,
//            )));
//
//        final extractedData = json.decode(response.body);
//
//        AddressMain addressMain = AddressMain.fromJson(extractedData);
//        print(extractedData.toString());
//
//        List<Address> addresses = addressMain.addressData;
//        print('ییییییییییییییییییی  ${addresses.length}');
//
//        _addressItems = addresses;
//      } else {
//        print('qqqqqqqqqqqqqqggggggggq');
//
//        _addressItems = addressList;
//      }
//      notifyListeners();
//    } catch (error) {
//      print(error.toString());
//      throw (error);
//    }
//  }
//
//  List<Address> get addressItems => _addressItems;
//
//  Future<void> getOrder(List<Address> addressList) async {
//    print('addAddress');
//    try {
//      if (isAuth) {
//        final prefs = await SharedPreferences.getInstance();
//        _token = prefs.getString('token');
//
//        final url = Urls.rootUrl + Urls.addressEndPoint;
//        final response = await post(url,
//            headers: {
//              'Authorization': 'Bearer $_token',
//              'Content-Type': 'application/json',
//              'Accept': 'application/json'
//            },
//            body: json.encode(AddressMain(
//              addressData: addressList,
//            )));
//
//        final extractedData = json.decode(response.body);
//
//        print(extractedData.toString());
//
//        _addressItems = addressList;
//      } else {
//        _addressItems = addressList;
//      }
//      notifyListeners();
//    } catch (error) {
//      print(error.toString());
//      throw (error);
//    }
//  }
//
//  Future<void> selectAddress(Address address) async {
//    print('selectAddress');
//    try {
//      _selectedAddress = address;
//
//      notifyListeners();
//    } catch (error) {
//      print(error.toString());
//      throw (error);
//    }
//  }
//
//  Address get selectedAddress => _selectedAddress;
//
//  Future<void> retrieveRegionList() async {
//    print('retrieveRegionList');
//
//    final url = Urls.rootUrl + Urls.regionEndPoint;
//
//    try {
//      final response = await get(url, headers: {
//        'Content-Type': 'application/json',
//        'Accept': 'application/json'
//      });
//
//      final extractedData = json.decode(response.body) as List;
//      print(extractedData);
//
//      List<Region> regionList = new List<Region>();
//
//      regionList = extractedData.map((i) => Region.fromJson(i)).toList();
//      print(regionList.length);
//
//      _regionItems = regionList;
//
//      notifyListeners();
//    } catch (error) {
//      print(error.toString());
//      throw (error);
//    }
//  }
//
//  List<Region> get regionItems => _regionItems;
//
//  Future<void> retrieveRegion(int regionId) async {
//    print('retrieveRegion');
//
//    final url = Urls.rootUrl + Urls.regionEndPoint + '/$regionId';
//    print(url);
//
//    try {
//      final response = await get(url, headers: {
//        'Content-Type': 'application/json',
//        'Accept': 'application/json'
//      });
//
//      final extractedData = json.decode(response.body);
//      print(extractedData);
//
//      _regionData = Region.fromJson(extractedData);
//
//      notifyListeners();
//    } catch (error) {
//      print(error.toString());
//      throw (error);
//    }
//  }
//
//  Region get regionData => _regionData;
}
