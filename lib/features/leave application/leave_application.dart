import 'package:flutter/material.dart';
import 'package:geo_flix/ui/widgets/loader_dialog.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import '../../../core/constants/colors.dart';
import '../../core/constants/strings.dart';


class LeaveApplication extends StatefulWidget {
  const LeaveApplication({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  LeaveApplicationWidgetState createState() => LeaveApplicationWidgetState();
}

class LeaveApplicationWidgetState extends State<LeaveApplication>
    with SingleTickerProviderStateMixin {
  final String toDate = "Select";
  late DateTime toDateInt;
  final String fromDate = "Select";
  final formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime(3000, 2, 1, 10, 20);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Leave Application'),
          backgroundColor: appbarcolor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:  SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Builder(
                    builder: (context) => Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Center(
                                child: Text(
                                  "Available Leaves",
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color: dashBoardColor,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: Colors.white60,
                                                    width: 3)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "CL - 1",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                    "poppins-medium"),
                                              ),
                                            )),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: dashBoardColor,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: Colors.white60,
                                                    width: 3)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "AL - 2",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                    "poppins-medium"),
                                              ),
                                            )),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: dashBoardColor,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: Colors.white60,
                                                    width: 3)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "ML - 0",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                    "poppins-medium"),
                                              ),
                                            )),
                                      ]
                                  )
                              ),
                              const Text("Your Manager"),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                                child: TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      labelText: ("manager name"),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 5.0),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: const Center(
                                                child: Text("Manager Details")),
                                            content: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text("managerName"),
                                                Text("managerDesignation"),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              // usually buttons at the bottom of the dialog
                                              TextButton(
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .resolveWith(
                                                        (states) => const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0),
                                                  ),
                                                  shape: MaterialStateProperty
                                                      .resolveWith(
                                                        (states) =>
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              2.0)),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith(
                                                        (states) => Colors.blue,
                                                  ),
                                                ),
                                                child: const Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                              ),
                              const Text("Today's Date"),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                                child: TextField(
                                  readOnly: true,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    labelText: 'date.year-date.month-date.day',
                                    labelStyle:
                                    TextStyle(color: Colors.black54),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black45, width: 1.0),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  const Text('From'),
                                  Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 20),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty
                                              .resolveWith(
                                                (states) =>
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                ),
                                          ),
                                          elevation: MaterialStateProperty
                                              .resolveWith((states) => 4),
                                          backgroundColor:
                                          MaterialStateProperty
                                              .resolveWith((states) =>
                                          Colors.white),
                                        ),
                                        onPressed: () {
                                          // DatePicker.showDatePicker(context,
                                          //     // theme: DatePickerTheme(
                                          //     //   containerHeight: 250.0,
                                          //     // ),
                                          //     showTitleActions: true,
                                          //     minTime: DateTime(date.year,
                                          //         date.month, date.day),
                                          //     maxTime: DateTime(2050, 12, 31),
                                          //     onConfirm: (date) {
                                          //       print('confirm $date');
                                          //       // _fromdate =
                                          //       //     getFormattedDate(date);
                                          //       setState(() {
                                          //         // _fromDateInt = date;
                                          //
                                          //         // if (todate != null) {
                                          //         //   setState(() {
                                          //         //     int _difference = _toDateInt
                                          //         //         ?.difference(
                                          //         //         _fromDateInt ??
                                          //         //             _toDateInt!)
                                          //         //         .inDays ??
                                          //         //         0;
                                          //         //     _difference += 1;
                                          //         //     if (_difference <= 0)
                                          //         //       leavesCount =
                                          //         //       "Invalid Dates";
                                          //         //     else
                                          //         //       leavesCount = _difference
                                          //         //           .toString();
                                          //         //   });
                                          //         // }
                                          //       });
                                          //     },
                                          //     currentTime: DateTime.now(),
                                          //     locale: LocaleType.en);
                                        },
                                        child:  const Text(
                                          "Select",
                                          style: TextStyle(
                                            color:
                                            dashBoardColor,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),),
                                  const Text('To'),
                                  Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 20),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty
                                              .resolveWith(
                                                (states) =>
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                ),
                                          ),
                                          elevation: MaterialStateProperty
                                              .resolveWith((states) => 4),
                                          backgroundColor:
                                          MaterialStateProperty
                                              .resolveWith((states) =>
                                          Colors.white),
                                        ),
                                        onPressed: () {
                                          // DatePicker.showDatePicker(context,
                                          //     // theme: DatePickerTheme(
                                          //     //   containerHeight: 250.0,
                                          //     // ),
                                          //     showTitleActions: true,
                                          //     minTime: DateTime(date.year,
                                          //         date.month, date.day),
                                          //     maxTime: DateTime(2022, 12, 31),
                                          //     onConfirm: (date) {
                                          //       print('confirm $date');
                                          //       // _todate = getFormattedDate(date);
                                          //       // setState(() {
                                          //       //   _toDateInt = date;
                                          //       //
                                          //       //   if (_fromDateInt != null) {
                                          //       //     setState(() {
                                          //       //       int _difference = _toDateInt
                                          //       //           ?.difference(
                                          //       //           _fromDateInt ??
                                          //       //               _toDateInt!)
                                          //       //           .inDays ??
                                          //       //           0;
                                          //       //       _difference += 1;
                                          //       //       if (_difference <= 0)
                                          //       //         leavesCount =
                                          //       //         "Invalid Dates";
                                          //       //       else
                                          //       //         leavesCount = _difference
                                          //       //             .toString();
                                          //       //     });
                                          //       //   }
                                          //       // });
                                          //     },
                                          //     currentTime: DateTime.now(),
                                          //     locale: LocaleType.en);
                                        },
                                        child: const Text(
                                          "Select",
                                          style: TextStyle(
                                              color:
                                              dashBoardColor,
                                              fontSize: 16.0),
                                        ),
                                      )),
                                ],
                              ),

                              Text('Number of days on leave: $leavesCount'),
                              Container(
                                padding:
                                const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: const Text('Type of leave'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  MSHCheckbox(
                                    size: 30,
                                    value: isChecked1,
                                    colorConfig: MSHColorConfig
                                        .fromCheckedUncheckedDisabled(
                                      checkedColor: dashBoardColor,
                                    ),
                                    style: MSHCheckboxStyle.stroke,
                                    onChanged: (selected) {
                                      setState(() {
                                        isChecked1 = selected;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Medical Leave'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  MSHCheckbox(
                                    size: 30,
                                    value: isChecked2,
                                    colorConfig: MSHColorConfig
                                        .fromCheckedUncheckedDisabled(
                                      checkedColor: dashBoardColor,
                                    ),
                                    style: MSHCheckboxStyle.stroke,
                                    onChanged: (selected) {
                                      setState(() {
                                        isChecked2 = selected;
                                        isDisabled != selected;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Annual Leave'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  MSHCheckbox(
                                    size: 30,
                                    value: isChecked3,
                                    colorConfig: MSHColorConfig
                                        .fromCheckedUncheckedDisabled(
                                      checkedColor: dashBoardColor,
                                    ),
                                    style: MSHCheckboxStyle.stroke,
                                    onChanged: (selected) {
                                      setState(() {
                                        isChecked3 = selected;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Casual Leave'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const TextField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText:
                                  "Message for Management (Optional)",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black54),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black54),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 16.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape:
                                        MaterialStateProperty.resolveWith(
                                              (states) => RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        elevation:
                                        MaterialStateProperty.resolveWith(
                                                (states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return 40;
                                              } else {
                                                return 4;
                                              }
                                            }),
                                        backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                                (states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return splashScreenColorBottom;
                                              } else {
                                                return splashScreenColorTop;
                                              }
                                            }),
                                      ),
                                      onPressed: () {
                                        if (validateData(context)) {
                                          onLoadingDialog(context);

                                          addLeave().then((check) {
                                            if (check == true) {
                                              pushData(context).then((_) {
                                                Navigator.of(context,
                                                    rootNavigator: true)
                                                    .pop('dialog');
                                                SnackBar data = SnackBar(
                                                  action: SnackBarAction(
                                                      textColor: Colors.white70,
                                                      label: "View",
                                                      onPressed: () {}),
                                                  content: const Text(
                                                      "Leave has been requested\nA notification will be sent to you once it is approved!",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                                  backgroundColor: Colors.blue,
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(data);
                                              });
                                            } else {
                                              Navigator.of(context,
                                                  rootNavigator: true)
                                                  .pop('dialog');
                                              SnackBar error = const SnackBar(
                                                content: Text(
                                                    "You don't have enough requested leaves",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                backgroundColor: Colors.red,
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(error);
                                            }
                                          });
                                        }
                                      },
                                      child: const Text('Submit',
                                          style:
                                          TextStyle(color: Colors.white)))),
                            ]
                        )
                    )
                )
            )
        ),
    );
  }



  void giveData(TextEditingController controller) {
    msg = controller.text;
  }

  bool validateData(BuildContext context) {
    bool returnVal = true;

    if (leavesCount == "-" || leavesCount == "Invalid Dates") {
      SnackBar error = const SnackBar(
        content: Text("Please enter valid dates",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
      returnVal = false;
    }

    if (leaveIndex == -1) {
      SnackBar error = const SnackBar(
        content: Text("Please select type of leave valid dates",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
      returnVal = false;
    }

    return returnVal;
  }

  addLeave() {}

  pushData(BuildContext context) {}
}

String getDoubleDigit(String value) {
  if (value.length >= 2) return value;
  return "0$value";
}

String getFormattedDate(DateTime day) {
  String formattedDate =
      "${getDoubleDigit(day.day.toString())}-${getDoubleDigit(day.month.toString())}-${getDoubleDigit(day.year.toString())}";
  return formattedDate;
}
