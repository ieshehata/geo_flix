import 'dart:async';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/attendance_mark.dart';
import '../../core/utils/geofencing.dart';
import '../../ui/widgets/attendance_Marker_buttons.dart';
import '../../ui/widgets/loader_dialog.dart';



class AttendanceRecorderWidget extends StatefulWidget {
  const AttendanceRecorderWidget({super.key, required this.title});
  final String title;

  @override
  AttendanceRecorderWidgetState createState() =>
      AttendanceRecorderWidgetState();
}

class AttendanceRecorderWidgetState extends State<AttendanceRecorderWidget> {
  final Completer<GoogleMapController> _controller = Completer();



  @override
  void initState() {
    super.initState();
    initPlatformState();

    Future.microtask(() {
       geoFencingService = GeoFencing.of(context).service
       ..addListener(onGeofenceStatusUpdate);
    });
  }

  @override
  void dispose() async {
    super.dispose();
    locationSubscription?.cancel();
     geoFencingService.removeListener(onGeofenceStatusUpdate);
  }

  void onGeofenceStatusUpdate() {
    if (mounted) {
      setState(() {
        // geofenceStatus = geoFencingService.geofenceStatus;
      });
    }
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
        //shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(20.0),
        //  ),
        title: const Text(
          "Mark your Attendance",
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
      body:  Stack(
        children: <Widget>[
          googleMap(context),
          buildContainer(context),
        ],
      ),
    );
  }

  Widget googleMap(BuildContext context) {
    double initialLat = 30.677515;
    double initialLong = 76.743902;
    double initialZoom = 15;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        circles: circles,
        initialCameraPosition: CameraPosition(
            target: LatLng(initialLat, initialLong), zoom: initialZoom),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          // _controller.complete(controller);
//           officeDatabase.getOfficeBasedOnUID(widget.user.uid).then((office) {
//             if (mounted) {
//               setState(() {
//                 rMax = office.radius;
//                 rMin = 3 * office.radius / 5;
//                 _radius = office.radius;
//                 Timer.periodic(new Duration(milliseconds: 100), (timer) {
//                   var radius =
//                   _circles.isEmpty ? office.radius : _circles.first.radius;
//                   if ((radius > rMax) || (radius < rMin)) {
//                     direction *= -1;
//                   }
//                   var _par = (radius / _radius) - 0.2;
//                   var radiusFinal = radius + direction * 10;
//                   if (!mounted) {
//                     timer.cancel();
//                     return;
//                   }
//                   setState(() {
//                     _circles.clear();
//                     _circles.add(Circle(
//                       circleId: CircleId("GeoFenceCircle"),
//                       center: LatLng(office.latitude, office.longitude),
//                       radius: radiusFinal,
//                       strokeColor: Colors.blueGrey,
//                       strokeWidth: 5,
//                       fillColor: Colors.blueGrey.withOpacity(0.6 * _par),
//                     ));
//                   });
// //            circleOption.fillOpacity = 0.6 * _par;
//
// //                circle.setOptions(circleOption);
//                 });
//               });
//             }
//           }
//           );
        },
      ),
    );
  }

  buildContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            inOutButton("IN", Colors.green, _callMarkInFunction),
            const Spacer(flex: 20),
            inOutButton("OUT", Colors.orangeAccent, _callMarkOutFunction),
          ],
        ),
      ),
    );
  }
  void _callMarkInFunction() {
    if (geofenceStatus == GeofenceStatus.init) {
      showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: const Center(
                  child: Text(
                    "Kindly retry after some time!",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),
            ),
          ));
    } else {
      onLoadingDialog(context);
      // officeDatabase.getOfficeBasedOnUID(widget.user.uid).then((office) {
      //   markInAttendance(
      //       context, office, _currentLocation!, widget.user, geofenceStatus);
      // });
    }
  }

  void _callMarkOutFunction() {
    if (geofenceStatus == GeofenceStatus.init) {
      showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: const Center(
                  child: Text(
                    "Kindly retry after some time!",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),
            ),
          ));
    } else {
      onLoadingDialog(context);
      // officeDatabase.getOfficeBasedOnUID(widget.user.uid).then((office) {
      //   markOutAttendance(
      //       context, office, _currentLocation!, widget.user, geofenceStatus);
      // });
    }
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 15, tilt: 50.0, bearing: 45.0)));
  }

  initPlatformState() async {
    await locationService.changeSettings(
        accuracy: LocationAccuracy.balanced, interval: 1000);

    LocationData? location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        permission = await locationService.requestPermission();
        print("Permission: $permission");
        if (permission == PermissionStatus.granted) {
          location = await locationService.getLocation();

          locationSubscription = locationService.onLocationChanged
              .listen((LocationData result) async {
            final newLocation = LatLng(
              result.latitude ?? 0,
              result.longitude ?? 0,
            );
            if (previousLocation != newLocation) {
              previousLocation = newLocation;
              currentCameraPosition = CameraPosition(
                target: newLocation,
                zoom: 16,
                tilt: 50.0,
                bearing: 45.0,
              );

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  currentCameraPosition,
                ),
              );
              if (mounted) {
                setState(() {
                  markers.clear();
                  markers.add(
                    Marker(
                      markerId: MarkerId("Current Location"),
                      position: newLocation,
                    ),
                  );
                });
              }
            }
          });
        }
      } else {
        bool serviceStatusResult = await locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
    });
  }
}
