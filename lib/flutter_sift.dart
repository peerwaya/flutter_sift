import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

final MethodChannel _channel =
    const MethodChannel('com.peerwaya.gotok/flutter_sift');

class FlutterSift {
  static bool _initialized = false;

  /// Initialize FlutterSync
  ///
  /// [accountId] - your sift account id
  ///
  /// [beaconKey] your sift beacon key
  ///
  static Future<void> initialize(
      {@required String accountId, @required String beaconKey}) async {
    assert(accountId != null || accountId.isEmpty,
        'accountId cannot be null or empty');
    assert(beaconKey != null || beaconKey.isEmpty,
        'beaconKey cannot be null or empty');
    if (_initialized) {
      return null;
    }
    try {
      await _channel.invokeMethod(
          'initialize', {'accountId': accountId, 'beaconKey': beaconKey});
    } on PlatformException {
      rethrow;
    }
  }

  static Future<void> setUserId({@required String userId}) async {
    assert(userId != null || userId.isEmpty, 'userId cannot be null or empty');
    if (!_initialized) {
      throw Exception('Has you initialized FlutterSift SDK?');
    }
    try {
      await _channel.invokeMethod('setUserId', {'userId': userId});
    } on PlatformException {
      rethrow;
    }
  }

  static Future<void> unSetUserId() async {
    if (!_initialized) {
      throw Exception('Has you initialized FlutterSift SDK?');
    }
    try {
      await _channel.invokeMethod('unSetUserId');
    } on PlatformException {
      rethrow;
    }
  }
}
