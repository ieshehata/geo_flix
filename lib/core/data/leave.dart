import 'dart:ui';

import 'package:flutter/material.dart';

import '../../features/leave status/leave_status.dart';
import '../constants/strings.dart';



class Leave {
  String key;
  DateTime appliedDate;
  DateTime fromDate;
  DateTime toDate;
  LeaveStatus status;// approved, pending, rejected, undetermined
  bool withdrawalStatus;
  String message;
  LeaveType type;  //ml, al, cl, undetermined
  String name;
  String userUid;

  Leave({
    required this.name,
    required this.key,
    required this.appliedDate,
    required this.fromDate,
    required this.toDate,
    required this.type,
    required this.status,
    required this.withdrawalStatus,
    required this.message,
    required this.userUid,
  });

  factory Leave.fromJson(String key, Map<String, dynamic> parsedJson) {
    return Leave(
      key: key,
      name: '',
      userUid: '',
      appliedDate: formattedProperDateTime(parsedJson['appliedDate']),
      fromDate: formattedProperDateTime(parsedJson['fromDate']),
      toDate: formattedProperDateTime(parsedJson['toDate']),
      type: getType(parsedJson['type']),
      status: getStatus(parsedJson['status']),
      withdrawalStatus: (0 != parsedJson['withdrawalStatus']),
      message: parsedJson['message'] == "" ? "none" : parsedJson['message'],
    );
  }
}




