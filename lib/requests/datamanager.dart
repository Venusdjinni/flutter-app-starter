import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter/models/persistence.dart';
import 'package:flutter_app_starter/requests/notifiers.dart';
import 'package:flutter_app_starter/requests/requests.dart';
import 'package:flutter_app_starter/requests/requests_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DataManager {
  static DataManager? _instance;

  static DataManager? get instance => _instance;

  // 0 for test, 1 for prod
  static const int applicationMode = 1;

  static const prefUserLogged = 'USER_LOGGED';
  static const prefThemeMode = 'THEME_MODE';

  static Future init() async {
    _instance ??= DataManager._();

    // requests and device info
    RequestsErrors.init();
    var i = await (Platform.isAndroid ? DeviceInfoPlugin().androidInfo : DeviceInfoPlugin().iosInfo);
    _instance!._deviceInfo = i;
    Requests.init(serverAddress: serverAddress);

    // directories
    _instance!._tempDir = await path_provider.getTemporaryDirectory();

    // preferences
    _instance!._prefs = await SharedPreferences.getInstance();

    // database
    _instance!._db ??= Database();

    // notifier
    _instance!._notifier = Notifier();

    return true;
  }

  late dynamic _deviceInfo;
  Directory? _tempDir;
  SharedPreferences? _prefs;
  Database? _db;
  late Notifier _notifier;

  static Directory? get temp => _instance!._tempDir;

  static SharedPreferences? get preferences => _instance?._prefs;

  static Database? get database => _instance!._db;

  static Notifier get notifier => _instance!._notifier;

  DataManager._();

  String? deviceName() {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = _deviceInfo as AndroidDeviceInfo;
      return androidDeviceInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = _deviceInfo as IosDeviceInfo;
      return iosDeviceInfo.name;
    } else return null;
  }

  String? deviceID() {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = _deviceInfo as AndroidDeviceInfo;
      return androidDeviceInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = _deviceInfo as IosDeviceInfo;
      return iosDeviceInfo.identifierForVendor;
    } else return null;
  }

  // les variables globales test/prod
  static String get serverAddress => applicationMode == 0 ? "https://server.dev/" : "https://server.prod/";
}

class AppThemeMode with ChangeNotifier {
  late SharedPreferences _prefs;
  static const system = 0,
      light = 1,
      dark = 2;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static List<int> values() => [system, light, dark];

  int get themeMode {
    switch (_prefs.getInt(DataManager.prefThemeMode)) {
      case AppThemeMode.system: return AppThemeMode.system;
      case AppThemeMode.light: return AppThemeMode.light;
      case AppThemeMode.dark: return AppThemeMode.dark;
      default: return AppThemeMode.light;
    }
  }

  String themeModeText([int? value]) {
    switch (value ?? themeMode) {
      case AppThemeMode.light: return "Clair";
      case AppThemeMode.dark: return "Sombre";
      case AppThemeMode.system: return "Système";
      default: return "Clair";
    }
  }

  void switchTheme(int theme) async {
    await DataManager.preferences!.setInt(DataManager.prefThemeMode, theme);
    notifyListeners();
  }
}