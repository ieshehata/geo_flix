import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import '../constants/strings.dart';
import '../data/office.dart';

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateAndStop(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Future<List<String>> getDeviceDetails() async {
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  const androidIdPlugin = AndroidId();

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      //UUID for Android
      try {
        identifier = await androidIdPlugin.getId() ?? 'Unknown ID';
      } on PlatformException {
        identifier = 'Failed to get Android ID.';
      }
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name ?? '';
      deviceVersion = data.systemVersion ?? '';
      identifier = data.identifierForVendor ?? ''; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

//if (!mounted) return;
  return [deviceName, deviceVersion, identifier];
}

DateTime getTodayDate() {
  DateTime dateToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second);
  return dateToday;
}

Icon getIcon(LeaveStatus leaveStatus) {
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return listOfIcons[0];

    case LeaveStatus.pending:
      return listOfIcons[1];

    case LeaveStatus.rejected:
      return listOfIcons[2];

    case LeaveStatus.undetermined:
      return listOfIcons[2];
  }
}

Color getColor(LeaveStatus leaveStatus) {
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return listOfColors[0];

    case LeaveStatus.pending:
      return listOfColors[1];

    case LeaveStatus.rejected:
      return listOfColors[2];

    case LeaveStatus.undetermined:
      return listOfColors[2];
  }
}

String getStatus(LeaveStatus leaveStatus) {
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return "Approved";

    case LeaveStatus.pending:
      return "Pending";

    case LeaveStatus.rejected:
      return "Rejected";

    case LeaveStatus.undetermined:
      return "Pending";
  }
}

String getDoubleDigit(String value) {
  if (value.length >= 2) return value;
  return "0$value";
}

String getFormattedDate(DateTime day) {
  String formattedDate = "${getDoubleDigit(day.day.toString())}-${getDoubleDigit(day.month.toString())}-${getDoubleDigit(day.year.toString())}";
  return formattedDate;
}

String getLeaveType(LeaveType leaveType) {
  switch (leaveType) {
    case LeaveType.al:
      return "Annual Leave";

    case LeaveType.ml:
      return "Medical Leave";

    case LeaveType.cl:
      return "Casual Leave";

    case LeaveType.undetermined:
      return "Leave";
  }
}

DateTime formattedProperDateTime(String date) {
  return DateTime.parse(
      "${date.toString().split("-").reversed.join("-")} 01:00:00");
}

String findLatestIn(listOfAttendanceIterable) {
  List finalList = listOfAttendanceIterable
      .where((attendance) => attendance.toString().substring(0, 2) == "in")
      .toList();

  if (finalList.isEmpty) return "";

  finalList.sort((a, b) {
    String time1 = a.toString().split("-")[1];
    String time2 = b.toString().split("-")[1];
    return time1.compareTo(time2);
  });

  return finalList.last.toString().split("-")[1];
}

String findLatestOut(listOfAttendanceIterable) {
  List finalList = listOfAttendanceIterable
      .where((attendance) => attendance.toString().substring(0, 3) == "out")
      .toList();

  if (finalList.isEmpty) return "";

  finalList.sort((a, b) {
    String time1 = a.toString().split("-")[1];
    String time2 = b.toString().split("-")[1];
    return time1.compareTo(time2);
  });

  return finalList.last.toString().split("-")[1];
}

String findFirstIn(listOfAttendanceIterable) {
  List finalList = listOfAttendanceIterable
      .where((attendance) => attendance.toString().substring(0, 2) == "in")
      .toList();

  if (finalList.isEmpty) return "";
  finalList.sort((a, b) {
    String time1 = a.toString().split("-")[1];
    String time2 = b.toString().split("-")[1];
    return time1.compareTo(time2);
  });

  return finalList.first.toString().split("-")[1];
}

String findFirstOut(listOfAttendanceIterable) {
  List finalList = listOfAttendanceIterable
      .where((attendance) => attendance.toString().substring(0, 3) == "out")
      .toList();

  if (finalList.isEmpty) return "";

  finalList.sort((a, b) {
    String time1 = a.toString().split("-")[1];
    String time2 = b.toString().split("-")[1];
    return time1.compareTo(time2);
  });

  return finalList.first.toString().split("-")[1];
}

bool checkSuccessiveIn(listOfAttendanceIterable) {
  if (listOfAttendanceIterable.length > 0) {
    String lastOut = findLatestOut(listOfAttendanceIterable);
    String lastIn = findLatestIn(listOfAttendanceIterable);

    if (lastIn == "" || (lastOut != "" && lastIn.compareTo(lastOut) <= 0)) {
      return true;
    } else {
      return false;
    }
  }
  return true;
}

bool checkSuccessiveOut(listOfAttendanceIterable) {
  if (listOfAttendanceIterable.length > 0) {
    String lastOut = findLatestOut(listOfAttendanceIterable);
    String lastIn = findLatestIn(listOfAttendanceIterable);

    if (lastOut == "" || (lastIn != "" && lastOut.compareTo(lastIn) <= 0)) {
      return true;
    } else {
      return false;
    }
  }
  return true;
}

void markInAttendance(
    BuildContext context,
    Office office,
    LocationData currentPosition,

    GeofenceStatus geoFenceStatus) async {

}

void markOutAttendance(
    BuildContext context,
    Office office,
    LocationData currentPosition,

    GeofenceStatus geoFenceStatus, GeofenceStatus geofenceStatus) async {

}


