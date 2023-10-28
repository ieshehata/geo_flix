import 'dart:async';
import 'dart:collection';

import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../features/attendance recorder/attendance_recorder.dart';
import '../../features/attendance summary/attendance_summary.dart';
import '../../features/leave application/leave_application.dart';
import '../../features/leave status/leave_status.dart';
import '../utils/geofencing.dart';


extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
    height: toDouble(),
  );
  SizedBox get pw => SizedBox(
    width: toDouble(),
  );
}

extension ImagePath on String {
  String get toPng => "assets/images/$this.png";
  String get toJpg => "assets/images/$this.jpg";
  String get toSvg => "assets/images/$this.svg";
}


void attendanceRecorderCallback(BuildContext context,) {
  Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => const AttendanceRecorderWidget(
            title: "Leave Status",

          )));
}

void attendanceSummaryCallback(BuildContext context) {
  Navigator.push(
    context,
    CupertinoPageRoute(
        builder: (context) => const AttendanceSummary(
          title: "Attendance Summary",

        )),
  );
}

bool shouldCheck = false;
bool shouldCheckDefault = false;
bool isChecked1 = false;
bool isChecked2 = false;
bool isChecked3 = false;
bool isDisabled = false;


void leaveApplicationCallback(BuildContext context) {
  Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => const LeaveApplication(
            title: "Leave Application",

          )));
}

void leaveStatusCallback(BuildContext context,) {
  Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => LeaveStatusWidget(
            title: "Leave Status",

          )));
}

List<List> infoAboutTiles = [
  [
    "assets/icons/attendance_recorder.png",
    "Attendance Recorder",
    "Mark your In and Out Time",
    attendanceRecorderCallback
  ],
  [
    "assets/icons/attendance_summary.png",
    "Attendance Summary",
    "Check your previous record",
    attendanceSummaryCallback
  ],
  [
    "assets/icons/leave_application.png",
    "Leaves Application",
    "Management",
    leaveApplicationCallback
  ],
  [
    "assets/icons/leave_status.png",
    "Leaves Status",
    "Check pending status of leaves",
    leaveStatusCallback
  ],
];


const String fence_id = "geofence_app_id";
const double radius_geofence = 150;
const String geofence_port_name = "geofence_port";

enum LeaveStatus { approved, pending, rejected, undetermined }
enum LeaveType { ml, al, cl, undetermined }
enum AppBarBehavior { normal, pinned, floating, snapping }
final formKey =  GlobalKey<FormState>();
var idController = TextEditingController();
var passController = TextEditingController();

late LinkedHashMap<DateTime, List> events;
late List selectedEvents;
late final AnimationController animationController;
late DateTime selectedDay;
CalendarFormat calendarFormat = CalendarFormat.month;

final Map<DateTime, List> holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 11, 18): ['Easter Monday'],
  DateTime(2019, 12, 25): ['Christmas Eve'],
};

List<Icon> listOfIcons = [
  const Icon(
    Icons.check,
    size: 60,
    color: Colors.green,
  ),
  const Icon(
    Icons.hourglass_empty,
    size: 60,
    color: Colors.orange,
  ),
  const Icon(
    Icons.cancel,
    size: 60,
    color: Colors.red,
  )
];

List<Color> listOfColors = [Colors.green, Colors.orange, Colors.red];

late DateTime _fromDateInt;
bool isSelected = false;

var date = DateTime.now();

bool ishalfday = false;
late String leave_type;
late int nofdays;
bool monVal = false;
String leavesCount = "-";
String msg = "none";

List<String> leaveType = [
  "Medical Leave",
  "Annual Leave",
  "Casual Leave",
];
int leaveIndex = -1;
String? errorMessage;


double zoomVal = 5.0;
//OfficeDatabase officeDatabase = new OfficeDatabase();
StreamSubscription<LocationData>? locationSubscription;
final Set<Marker> markers = {};
final Set<Circle> circles =  Set();
LatLng previousLocation = const LatLng(0, 0);
var direction = 1;
var rMin;
var rMax;
final Location locationService =  Location();
PermissionStatus? permission;
String? error;
late GeoFencingService geoFencingService;
GeofenceStatus geofenceStatus = GeofenceStatus.init;
late CameraPosition currentCameraPosition;


enum Gender { Male, Female, Other }

enum SkillCategory {
//  TODO
  Unskilled,
  Skilled
}

enum EmployeeFunction {
  // TODO
  ADD_HERE
}

enum EmployeeSubFunction {
  // TODO
  ADD_HERE
}

enum Grade {
  // TODO
  ADD_HERE
}

enum Designation {
  // TODO
  ADD_HERE
}

enum Nationality {
  Afghan,
  Albanian,
  Algerian,
  American,
  Andorran,
  Angolan,
  Antiguans,
  Argentinean,
  Armenian,
  Australian,
  Austrian,
  Azerbaijani,
  Bahamian,
  Bahraini,
  Bangladeshi,
  Barbadian,
  Barbudans,
  Batswana,
  Belarusian,
  Belgian,
  Belizean,
  Beninese,
  Bhutanese,
  Bolivian,
  Bosnian,
  Brazilian,
  British,
  Bruneian,
  Bulgarian,
  Burkinabe,
  Burmese,
  Burundian,
  Cambodian,
  Cameroonian,
  Canadian,
  Cape,
  Verdean,
  Central_African,
  Chadian,
  Chilean,
  Chinese,
  Colombian,
  Comoran,
  Congolese,
  Costa_Rican,
  Croatian,
  Cuban,
  Cypriot,
  Czech,
  Danish,
  Djibouti,
  Dominican,
  Dutch,
  East_Timorese,
  Ecuadorean,
  Egyptian,
  Emirian,
  Equatorial_Guinean,
  Eritrean,
  Estonian,
  Ethiopian,
  Fijian,
  Filipino,
  Finnish,
  French,
  Gabonese,
  Gambian,
  Georgian,
  German,
  Ghanaian,
  Greek,
  Grenadian,
  Guatemalan,
  Guinea_Bissauan,
  Guinean,
  Guyanese,
  Haitian,
  Herzegovinian,
  Honduran,
  Hungarian,
  I_Kiribati,
  Icelander,
  Indian,
  Indonesian,
  Iranian,
  Iraqi,
  Irish,
  Israeli,
  Italian,
  Ivorian,
  Jamaican,
  Japanese,
  Jordanian,
  Kazakhstani,
  Kenyan,
  Kittian_and_Nevisian,
  Kuwaiti,
  Kyrgyz,
  Laotian,
  Latvian,
  Lebanese,
  Liberian,
  Libyan,
  Liechtensteiner,
  Lithuanian,
  Luxembourger,
  Macedonian,
  Malagasy,
  Malawian,
  Malaysian,
  Maldivian,
  Malian,
  Maltese,
  Marshallese,
  Mauritanian,
  Mauritian,
  Mexican,
  Micronesian,
  Moldovan,
  Monacan,
  Mongolian,
  Moroccan,
  Mosotho,
  Motswana,
  Mozambican,
  Namibian,
  Nauruan,
  Nepalese,
  New_Zealander,
  Ni_Vanuatu,
  Nicaraguan,
  Nigerian,
  Nigerien,
  North_Korean,
  Northern_Irish,
  Norwegian,
  Omani,
  Pakistani,
  Palauan,
  Panamanian,
  Papua_New_Guinean,
  Paraguayan,
  Peruvian,
  Polish,
  Portuguese,
  Qatari,
  Romanian,
  Russian,
  Rwandan,
  Saint_Lucian,
  Salvadoran,
  Samoan,
  San_Marinese,
  Sao_Tomean,
  Saudi,
  Scottish,
  Senegalese,
  Serbian,
  Seychellois,
  Sierra_Leonean,
  Singaporean,
  Slovakian,
  Slovenian,
  Solomon_Islander,
  Somali,
  South_African,
  South_Korean,
  Spanish,
  Sri_Lankan,
  Sudanese,
  Surinamer,
  Swazi,
  Swedish,
  Swiss,
  Syrian,
  Taiwanese,
  Tajik,
  Tanzanian,
  Thai,
  Togolese,
  Tongan,
  Trinidadian_or_Tobagonian,
  Tunisian,
  Turkish,
  Tuvaluan,
  Ugandan,
  Ukrainian,
  Uruguayan,
  Uzbekistani,
  Venezuelan,
  Vietnamese,
  Welsh,
  Yemenite,
  Zambian,
  Zimbabwean
}

enum MaritalStatus {
  Unmarried,
  Married,
  ItsComplicated,
}

enum Religion {
  African_Traditional,
  Agnostic,
  Atheist,
  Bahai,
  Buddhism,
  Cao_Dai,
  Chinese_traditional_religion,
  Christianity,
  Hinduism,
  Islam,
  Jainism,
  Juche,
  Judaism,
  Neo_Paganism,
  Non_religious,
  Rastafarianism,
  Secular,
  Shinto,
  Sikhism,
  Spiritism,
  Tenrikyo,
  Unitarian_Universalism,
  Zoroastrianism,
  Primal_indigenous,
  Other
}
enum attendanceType { IN, OUT, UNDETERMINED }

enum Entity {
  //TODO
  ADD_HERE
}

enum BloodGroup {
  A_positive,
  A_negative,
  B_positive,
  B_negative,
  AB_positive,
  O_positive,
  O_negative
}

enum EmployeeType { Trainee, Manager }

enum Role {
  // TODO
  ADD_HERE
}







