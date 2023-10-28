import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';




Widget buildTile(
    String icon, String title, String subtitle, BuildContext context,
    [Function(BuildContext)? onTap]) {
  return Material(
      elevation: 10.0,
      shadowColor: dashBoardColor,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
      /*Color.fromRGBO(51, 51, 102, 1),*/
      child: InkWell(
        onTap: onTap != null
            ? () {
                onTap(context);
              } //  Implement here onTap function
            : () => print("Not yet set"),
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
                    icon,
                    height: 50,
                  ),
                )),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
        ),
      ));
}
