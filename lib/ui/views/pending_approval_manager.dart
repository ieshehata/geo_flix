import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/data/leave.dart';
import '../../core/utils/functions.dart';

class LeaveApprovalByManagerWidget extends StatefulWidget {
  const LeaveApprovalByManagerWidget(
      {Key? key, required this.title})
      : super(key: key);
  final String title;


  @override
  LeaveApprovalByManagerWidgetState createState() =>
      LeaveApprovalByManagerWidgetState();
}

class LeaveApprovalByManagerWidgetState
    extends State<LeaveApprovalByManagerWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Review Leaves'.toUpperCase()),
          backgroundColor: appbarcolor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
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
    return Text('data');
  }

  Widget leaveRow(Leave leave) {
    final leaveCard = Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      decoration: BoxDecoration(
        color: dashBoardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black38,
              blurRadius: 10.0,
              offset: Offset(0.0, 2.0))
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: const BoxConstraints.expand(),
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
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 Text(
                  "Message: ${leave.message}",
                  style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'poppins-medium',
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0),
                ),
              ],
            ),
            Expanded(
              child:  Text(
                  "Applied on ${getFormattedDate(leave.appliedDate)} by ${leave.name}",
                  style: const TextStyle(
                      color: Color(0x66FFFFFF),
                      fontFamily: 'poppins-medium',
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      letterSpacing: 1)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green),
                    ),
                    onPressed: () async {

                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Column(children: <Widget>[
                        Icon(Icons.check_circle,
                            size: 20.0, color: Color(0x66FFFFFF)),
                        Text(
                          'Approve',
                          style: TextStyle(
                              color: Color(0x66FFFFFF),
                              fontFamily: 'poppins-medium',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red),
                    ),
                    onPressed: () async {

                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Column(children: <Widget>[
                        Icon(Icons.clear,
                            size: 20.0, color: Color(0x66FFFFFF)),
                        Text(
                          'Reject',
                          style: TextStyle(
                              color: Color(0x66FFFFFF),
                              fontFamily: 'poppins-medium',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return  Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child:  Stack(
        children: <Widget>[
          leaveCard,
        ],
      ),
    );
  }
}





