import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_flix/ui/widgets/dashboard_tile.dart';

import '../../core/constants/colors.dart';
import '../attendance recorder/attendance_recorder.dart';
import '../attendance summary/attendance_summary.dart';
import '../leave application/leave_application.dart';
import '../leave status/leave_status.dart';

class Dashboard extends StatelessWidget {
   const Dashboard({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 55.0),
          child:  Text(
            "DASHBOARD",
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: "Poppins-Medium",
                fontWeight: FontWeight.w200),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: dashBoardColor,
        leading:  IconButton(
          onPressed: () {

          },
          icon:  const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            colors: [splashScreenColorBottom, splashScreenColorTop],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
            children: [
              Material(
                  elevation: 10.0,
                  shadowColor: dashBoardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                            const AttendanceRecorderWidget(
                              title: "Attendance Recorder",
                            )),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(
                                    'assets/icons/attendance_recorder.png',
                                    height: 50,
                                  ),
                                )),
                            const Text(
                              "Attendance Recorder",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Mark your In and Out Time",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                  )),
              Material(
                  elevation: 10.0,
                  shadowColor: dashBoardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const AttendanceSummary(
                              title: "Attendance Summary",
                            )),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(
                                    'assets/icons/attendance_summary.png',
                                    height: 50,
                                  ),
                                )),
                            const Text(
                              "Attendance Summary",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Check your previous record",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                  )),
              Material(
                  elevation: 10.0,
                  shadowColor: dashBoardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const LeaveApplication(
                              title: "Leaves Application",
                            )),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(
                                    'assets/icons/leave_application.png',
                                    height: 50,
                                  ),
                                )),
                            const Text(
                              "Leaves Application",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Management",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                  )),
              Material(
                  elevation: 10.0,
                  shadowColor: dashBoardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => LeaveStatusWidget(
                              title: "Leaves Status",
                            )),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(
                                    'assets/icons/leave_status.png',
                                    height: 50,
                                  ),
                                )),
                            const Text(
                              "Leaves Status",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Check pending status of leaves",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                  )),
            ],
          ),
        ),),

    );
  }
}












