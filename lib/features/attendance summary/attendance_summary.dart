import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/data/AttendaceList.dart';
import '../../ui/widgets/loader_dialog.dart';




class AttendanceSummary extends StatefulWidget {
  const AttendanceSummary({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _AttendanceSummaryState createState() => _AttendanceSummaryState();
}

class _AttendanceSummaryState extends State<AttendanceSummary>
    with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    final selectedDay = DateTime.now();

    events = LinkedHashMap();

    selectedEvents = events[selectedDay] ?? [];

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onDaySelected(DateTime day, List events) {
    onLoadingDialog(context);
    AttendanceDatabase.getAttendanceBasedOnUID(2 as String)
        .then((AttendanceList attendanceList) {
      attendanceList.attendanceList.forEach((Attendance attendance) {
        events.add(
            "Type: ${attendance.type.toString().split('.').last} Time: ${attendance.time.hour} hours ${attendance.time.minute} minutes at ${attendance.office} ");
        setState(() {
          selectedEvents = events;
        });
      });

      if (attendanceList.attendanceList.isEmpty) {
        setState(() {
          selectedEvents = [];
        });
      }

      Navigator.of(context, rootNavigator: true).pop('dialog');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        automaticallyImplyLeading: false,
        leading:  IconButton(
          icon:  const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Attendance History",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Medium",
              fontSize: 22,
              letterSpacing: .6,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0.8,
        centerTitle: true,
        bottomOpacity: 0,
      ),
      body: SafeArea(
        child: Container(
          color: dashBoardColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildTableCalendarWithBuilders(),
              const SizedBox(height: 8.0),
              _buildButtons(),
              const SizedBox(height: 8.0),
              Expanded(child: _buildEventList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      focusedDay: DateTime.now(),
      firstDay: DateTime(2000),
      lastDay: DateTime.now(),
      // eventLoader: (dateTime) => _events[dateTime]!,
      onDaySelected: (DateTime selectedDay, DateTime focusedDay){
        selectedDay = selectedDay;
        onDaySelected(selectedDay, selectedEvents);
        animationController.forward(from: 0.0);
      },
      holidayPredicate: (dateTime) => holidays
          .containsKey(DateTime(dateTime.year, dateTime.month, dateTime.day)),
      calendarFormat: calendarFormat,
      formatAnimationCurve: Curves.fastOutSlowIn,
      formatAnimationDuration: const Duration(milliseconds: 400),
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        defaultTextStyle: const TextStyle().copyWith(color: Colors.white),
        weekendTextStyle: const TextStyle().copyWith(color: Colors.grey),
        holidayTextStyle: const TextStyle().copyWith(color: Colors.white),
        outsideTextStyle: const TextStyle().copyWith(color: Colors.grey),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: const TextStyle().copyWith(color: Colors.white),
        weekendStyle: const TextStyle().copyWith(color: Colors.white),
      ),
      headerStyle: const HeaderStyle(
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white60),
        rightChevronIcon:
        Icon(Icons.chevron_right, color: Colors.white60),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28),
        titleCentered: true,
        formatButtonVisible: false,
      ),
      calendarBuilders: const CalendarBuilders(
        // selectedBuilder: (context, date, _) {
        //   return FadeTransition(
        //     opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
        //     child: Container(
        //       margin: const EdgeInsets.all(4.0),
        //       padding: const EdgeInsets.only(top: 11.0, left: 12.0),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.amber[500],
        //       ),
        //       width: 100,
        //       height: 100,
        //       child: Text(
        //         '${date.day}',
        //         style: TextStyle().copyWith(
        //             fontSize: 18.0,
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   );
        // },
        // todayBuilder: (context, date, _) {
        //   return Container(
        //     margin: const EdgeInsets.all(4.0),
        //     padding: const EdgeInsets.only(top: 11.0, left: 12.0),
        //     width: 100,
        //     height: 100,
        //     child: Text(
        //       '${date.day}',
        //       style: TextStyle().copyWith(
        //           fontSize: 18.0,
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Color.fromRGBO(29, 209, 161, 1.0),
        //     ),
        //   );
        // },
        // markersBuilder: (context, date, events, holidays) {
        //   final children = <Widget>[];

        //   if (events.isNotEmpty) {
        //     children.add(
        //       Positioned(
        //         right: 1,
        //         bottom: 1,
        //         child: _buildEventsMarker(date, events),
        //       ),
        //     );
        //   }

        //   if (holidays.isNotEmpty) {
        //     children.add(
        //       Positioned(
        //         right: -2,
        //         top: -2,
        //         child: _buildHolidaysMarker(),
        //       ),
        //     );
        //   }
        //   return children;
        // },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // color: _calendarController.isSelected(date)
        //     ? Colors.brown[500]
        //     : _calendarController.isToday(date)
        //         ? Colors.brown[300]
        //         : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return const Icon(
      Icons.weekend,
      size: 20.0,
      color: Colors.blueGrey,
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
              ),
              child: const Text(
                'Month',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (calendarFormat != CalendarFormat.month) {
                  setState(() {
                    calendarFormat = CalendarFormat.month;
                  });
                }
              },
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(Colors.teal),
            //   ),
            //   child: Text(
            //     '2 weeks',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onPressed: () {
            //     if (_calendarFormat != CalendarFormat.twoWeeks) {
            //       setState(() {
            //         _calendarFormat = CalendarFormat.twoWeeks;
            //       });
            //     }
            //   },
            // ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              child: const Text(
                'Week',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (calendarFormat != CalendarFormat.week) {
                  setState(() {
                    calendarFormat = CalendarFormat.week;
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        Text(
          "Attendance History Preview".toUpperCase(),
          style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
              letterSpacing: 3),
        ),
        const SizedBox(height: 2.0),
      ],
    );
  }

  Widget _buildEventList() {
    return selectedEvents.isNotEmpty
        ? ListView(
      children: selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(
            event.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    )
        : Text(
      "No Records Found".toUpperCase(),
      style: const TextStyle(
          color: Colors.white70,
          fontSize: 22,
          fontFamily: "poppins-medium"),
    );
  }
}
