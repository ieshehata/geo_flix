
import '../constants/strings.dart';

class AttendanceList {
  DateTime dateTime = DateTime.now();
  List<Attendance> attendanceList = [];

  AttendanceList({required this.dateTime,required  this.attendanceList});

  DateTime get date {
    return dateTime;
  }

  List<Attendance> get listOfAttendance {
    return attendanceList;
  }

  AttendanceList.fromJson(
      dynamic dataSnapshot, String selectedDate, Map<String, String> map) {
    List<Attendance> attendanceList = [];

    if (dataSnapshot != null) {
      dataSnapshot.cast<String, dynamic>().forEach((key, value) {
        attendanceType type = (key.toString().split('-')[0] == "in")
            ? attendanceType.IN
            : (key.toString().split('-')[0] == "out"
                ? attendanceType.OUT
                : attendanceType.UNDETERMINED);
        String formattedString = selectedDate.split("-").reversed.join("-");
        formattedString = "$formattedString ${value["time"]}";
        DateTime time = DateTime.parse(formattedString);

        attendanceList.add(
            Attendance(type: type, time: time, office: map[value["office"]]!));
      });
    }
    this.attendanceList = attendanceList;
  }
}

class Attendance {
  attendanceType type;
  DateTime time;
  String office;

  Attendance({required this.type,required  this.time,required  this.office});
}

String getDoubleDigit(String value) {
  if (value.length >= 2) return value;
  return "0" + value;
}

String getFormattedDate(DateTime day) {
  String formattedDate = getDoubleDigit(day.day.toString()) +
      "-" +
      getDoubleDigit(day.month.toString()) +
      "-" +
      getDoubleDigit(day.year.toString());
  return formattedDate;
}

String getFormattedTime(DateTime day) {
  String time = getDoubleDigit(day.hour.toString()) +
      ":" +
      getDoubleDigit(day.minute.toString()) +
      ":" +
      getDoubleDigit(day.second.toString());

  return time;
}

class AttendanceDatabase {
  //static final _databaseReference = FirebaseDatabase.instance.reference();
  static final AttendanceDatabase _instance = AttendanceDatabase._internal();

  factory AttendanceDatabase() {
    return _instance;
  }

  AttendanceDatabase._internal();

  static  getAttendanceBasedOnUID(String uid) {
    // DataSnapshot dataSnapshot =
    //     (await _databaseReference.child("Attendance").child(uid).once()).snapshot;
    return '2';
  }

// static  getAttendanceOfParticularDateBasedOnUID(
//     String uid, DateTime dateTime)  {
//  getAttendanceBasedOnUID(uid);
//   String formattedDate = getFormattedDate(dateTime);
//   return  (snapshot.value as Map)[formattedDate];
// }

// static getOfficeFromID()  {
//   DataSnapshot dataSnapshot =
//       ( _databaseReference.child("location").once()).snapshot;
//   Map<String, String> map =  Map();
//
//   (dataSnapshot.value as Map).forEach((key, value) {
//     map[key] = value["name"];
//   });
//   return map;
// }

// static <AttendanceList> getAttendanceListOfParticularDateBasedOnUID(
//     String uid, DateTime dateTime)  {
//  // var snapshot =  getAttendanceOfParticularDateBasedOnUID(uid, dateTime);
//   //var mapOfOffice =  getOfficeFromID();
//   AttendanceList attendanceList = AttendanceList.fromJson(
//       snapshot, getFormattedDate(dateTime), mapOfOffice);
//   attendanceList.dateTime = dateTime;
//
//   return attendanceList;
// }
//
// static Future markAttendance(
//     String uid, DateTime dateTime, Office office, String markType) async {
//   String time = getFormattedTime(dateTime);
//   String date = getFormattedDate(dateTime);
//   var json = {
//     "office": office.getKey,
//     "time": time,
//   };
//   String markChild = markType + "-" + time;
//   return _databaseReference
//       .ref
//       .child("Attendance")
//       .child(uid)
//       .child(date)
//       .child(markChild)
//       .update(json);
// }
}



