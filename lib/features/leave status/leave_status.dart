import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/data/leave.dart';

class LeaveStatusWidget extends StatefulWidget {
  LeaveStatusWidget({Key? key, required this.title})
      : super(key: key);
  final String title;


  @override
  LeaveStatusWidgetState createState() => LeaveStatusWidgetState();
}

class LeaveStatusWidgetState extends State<LeaveStatusWidget> {
  int y = 4;
  final LeaveDatabase leaveDatabase =  LeaveDatabase();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Leave Status'.toUpperCase()),
          backgroundColor: appbarcolor,
          leading:  IconButton(
            icon:  const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: <Widget>[
            leaveList(),
          ],
        ));
  }

  Widget leaveList() {
    return Flexible(
      child: Container(
        color: Colors.white,
        child: const Text(''),
      ),
    );
  }

  Widget leaveRow(Leave leave) {
    final thumbnail =  Container(
      alignment:  const FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 15.0),
      child:  Hero(
          tag: leave.key,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 5, color: getColor(leave.status))),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: getIcon(leave.status),
              ))),
    );
    final leaveCard = Container(
      height: 200,
      margin: const EdgeInsets.only(left: 45.0, right: 20.0),
      decoration:  BoxDecoration(
        color: const Color(0xFF8685E5),
        shape: BoxShape.rectangle,
        borderRadius:  BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
           BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset:  Offset(0.0, 2.0))
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints:  const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
             Text(getLeaveType(leave.type),
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'poppins-medium',
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )),
             Text(
                "${getFormattedDate(leave.fromDate)} - ${getFormattedDate(leave.toDate)}",
                style: const TextStyle(
                  color: Color(0x66FFFFFF),
                  fontFamily: 'poppins-medium',
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                )),
//            Container(
//              color: Colors.white70,
//              width: 170.0,
//              height: 1.0,
//              margin: const EdgeInsets.symmetric(vertical: 8.0),
//            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 const Padding(
                  padding: EdgeInsets.all(2.0),
                  child:  Icon(Icons.calendar_today,
                      size: 14.0, color: Color(0x66FFFFFF)),
                ),
                 const Text(
                     "Withdrawn",
                  // leave.withdrawalStatus == false
                  //     ? getStatus(leave.status as String )
                  //     : ,
                  style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'poppins-medium',
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0),
                ),
                 Container(width: 70.0),
                ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          elevation:
                              MaterialStateProperty.resolveWith((states) => 4),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.purple,
                          ),
                        ),
                        onPressed: () async {

                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Column(children: <Widget>[
                             Icon(Icons.arrow_upward,
                                size: 20.0, color: Color(0x66FFFFFF)),
                             Text(
                              'Withdraw',
                              style: TextStyle(
                                  color: Color(0x66FFFFFF),
                                  fontFamily: 'poppins-medium',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.0),
                            ),
                          ]),
                        ),
                      )
              ],
            ),
            Text("Applied on ${getFormattedDate(leave.appliedDate)}",
                style: const TextStyle(
                    color: Color(0x66FFFFFF),
                    fontFamily: 'poppins-medium',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    letterSpacing: 1)),
          ],
        ),
      ),
    );
    return  Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child:  Stack(
        children: <Widget>[
          leaveCard,
          thumbnail,
        ],
      ),
    );
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



DateTime formattedProperDateTime(String date) {
  return DateTime.parse(
      "${date.toString().split("-").reversed.join("-")} 01:00:00");
}

LeaveType getType(String type) {
  if (type == "al") {
    return LeaveType.al;
  }
  if (type == "cl") {
    return LeaveType.cl;
  }
  if (type == "ml") {
    return LeaveType.ml;
  }
  return LeaveType.undetermined;
}

LeaveStatus getStatus(String status) {
  if (status == "approved") {
    return LeaveStatus.approved;
  }
  if (status == "pending") {
    return LeaveStatus.pending;
  }
  if (status == "rejected") {
    return LeaveStatus.rejected;
  }
  return LeaveStatus.undetermined;
}

//
// String getStatus(LeaveStatus leaveStatus) {
//   switch (leaveStatus) {
//     case LeaveStatus.approved:
//       return "Approved";
//
//     case LeaveStatus.pending:
//       return "Pending";
//
//     case LeaveStatus.rejected:
//       return "Rejected";
//
//     case LeaveStatus.undetermined:
//       return "Pending";
//   }
// }

class LeaveDatabase {
  static final LeaveDatabase _instance = LeaveDatabase._internal();

  factory LeaveDatabase() {
    return _instance;
  }

  LeaveDatabase._internal();




}





