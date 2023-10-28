import 'package:flutter/material.dart';

void onLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SizedBox(
          height: 30,
          child: Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      "assets/gif/loading-gif.gif",
                      width: 70,
                    )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "LOADING",
                    style: TextStyle(
                        fontFamily: "Poppins-Bold",
                        fontSize: 30,
                        letterSpacing: .6,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ));
    },
  );
}
