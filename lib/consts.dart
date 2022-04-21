import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void showLoadingBarrier(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (_) {
      return WillPopScope(
          child: Container(),
          onWillPop: () async {
            return false;
          }
      );
    },
  );
}

enum ToastLength {
  SHORT,
  LONG,
}

void showToast({required String msg, ToastLength length = ToastLength.SHORT, bool forceToast = false}) {
  if (Platform.isAndroid || forceToast)
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length == ToastLength.SHORT ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      timeInSecForIosWeb: length == ToastLength.SHORT ? 1 : 3,
      gravity: ToastGravity.BOTTOM
  );
}

Future<bool> _requestCameraPermission(BuildContext context) async {
  PermissionStatus status = await Permission.camera.status;
  print('status = $status');
  if (status == PermissionStatus.granted)
    return true;

  PermissionStatus permissions = await Permission.camera.request();

  print('$permissions');

  if (permissions == PermissionStatus.denied) {
    return _showRetryPermissionDialog(context, 'STRING_PERMISSIONS_CAMERA_DENIED', _requestCameraPermission);
  } else if (permissions == PermissionStatus.restricted) {
    return _showRetryPermissionDialog(context, 'STRING_PERMISSIONS_CAMERA_RESTRICTED', _requestCameraPermission);
  }

  return true;
}

Future<bool> _requestGalleryPermission(BuildContext context) async {
  PermissionStatus status = await Permission.photos.status;
  print('status = $status');
  if (status == PermissionStatus.granted)
    return true;

  PermissionStatus permissions = await Permission.photos.request();

  print('$permissions');

  if (permissions == PermissionStatus.denied) {
    return _showRetryPermissionDialog(context, 'STRING_PERMISSIONS_PHOTOS_DENIED', _requestGalleryPermission);
  } else if (permissions == PermissionStatus.restricted) {
    return _showRetryPermissionDialog(context, 'STRING_PERMISSIONS_PHOTOS_RESTRICTED', _requestGalleryPermission);
  }

  return true;
}

Future<bool> _showRetryPermissionDialog(BuildContext context, String msg, Function retry) async {
  bool? result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            // ferme le dialog et ouvre les paramètres
            onPressed: () async {
              Navigator.of(_).pop();
              openAppSettings();
            },
            child: const Text('Autoriser'),
          ),
          TextButton(
            onPressed: () => Navigator.of(_).pop(),
            child: const Text('Passer'),
          )
        ],
      )
  );
  return result ?? false;
}

Future<File?> pickImage(BuildContext context, {required ImageSource source}) async {
  bool request = await (source == ImageSource.gallery ? _requestGalleryPermission(context) : _requestCameraPermission(context));

  if (request) {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file == null)
      return null;
    return File(file.path);
  }
  return null;
}

String dateToString(BuildContext context, DateTime? date, {bool showHour = false, bool hoursOnly = false, bool compact = false}) {
  bool french = Localizations.localeOf(context).languageCode == 'fr';

  List<String> format = french ? [dd, " ", MM, " ", yyyy] : [MM, " ", dd, ", ", yyyy];
  if (compact)
    format = french ? [dd, "/", mm] : [mm, "/", dd];

  if (showHour) {
    format.addAll([", ", HH, ":", nn]);
    format.remove(MM);
    format.insert(2, M);
  }
  if (hoursOnly)
    format = [HH, ":", nn];

  return date == null ? "" : formatDate(date, format, locale: french ? const FrenchDateLocale() : const EnglishDateLocale());
}

String durationToString(int? duration) {
  if (duration == null)
    return "00:00";

  int minutes = (duration / 60).floor();
  int seconds = duration - minutes * 60;
  int hours = (minutes / 60).floor();
  if (hours > 0)
    minutes %= 60;

  return "${hours > 0 ? "${hours < 10 ? "0$hours" : hours}:" : ""}"
      "${minutes < 10 ? "0$minutes" : minutes}:"
      "${seconds < 10 ? "0$seconds" : seconds}";
}