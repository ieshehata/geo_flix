import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_flix/features/login/view_model/login_cubit.dart';
import 'package:geo_flix/features/login/view_model/login_states.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../ui/widgets/custom_button.dart';
import '../../ui/widgets/custom_text_form_field.dart';





class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:  AssetImage('assets/back.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/logo/logo.png",
                          width: ScreenUtil().setWidth(220),
                          height: ScreenUtil().setHeight(220),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(40),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("GeoFlix",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Bold",
                                      color: appbarcolor,
                                      fontSize: ScreenUtil().setSp(90),
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold)),
                              Text("Geo-Attendance and HR Management System",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Poppins-Bold",
                                      color: Colors.black54,
                                      fontSize: ScreenUtil().setSp(25),
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(90),
                    ),
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Login",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(45),
                                      fontFamily: "Poppins-Bold",
                                      letterSpacing: .6)),
                              SizedBox(
                                height: ScreenUtil().setHeight(30),
                              ),
                              SizedBox(
                                height: 60,
                                child: CustomTextFormField(
                                    controller: idController,
                                    keyboardType: TextInputType.phone,
                                    text: 'Employee ID',
                                    prefixIcon: Icons.person,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Employee ID mustn\'t be empty.';
                                      }
                                      return null;
                                    }),
                              ),
                              SizedBox(
                                height: 60,
                                child:CustomTextFormField(
                                    controller: passController,
                                    keyboardType: TextInputType.visiblePassword,
                                    text: 'Password',
                                    obscureText: LoginCubit.get(context).obscureText,
                                    suffixIcon: LoginCubit.get(context).suffix,
                                    suffixPress: () {
                                      LoginCubit.get(context).changeEyeIcon();
                                    },
                                    prefixIcon: Icons.lock_rounded,
                                    onSubmitted: (value) {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            id: idController.text,
                                            pass: passController.text);
                                      }
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password mustn\'t be empty.';
                                      }
                                      return null;
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.resolveWith(
                                            (states) => const EdgeInsets.symmetric(horizontal: 16.0),
                                      ),
                                      shape: MaterialStateProperty.resolveWith(
                                            (states) => const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.resolveWith(
                                            (states) => Colors.blue,
                                      ),
                                    ),
                                    onPressed: () => formKey.currentState?.reset(),
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                          color: dashBoardColor,
                                          fontFamily: "Poppins-Medium",
                                          fontSize: ScreenUtil().setSp(28)),
                                    ),
                                  ),
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: dashBoardColor,
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil().setSp(28)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    ConditionalBuilder(
                      condition: LoginLoadingState is! LoginLoadingState,
                      builder: (BuildContext context) => CustomButton(
                          onPressed: () {
                            // if (formKey.currentState!.validate()) {
                            //   LoginCubit.get(context).userLogin(
                            //       id: idController.text,
                            //       pass: passController.text);
                            // }
                          },
                          text: 'login',
                          icon: Icons.arrow_forward_ios_rounded),
                      fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(
                              color: dashBoardColor)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        const Text("Other Options",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Poppins-Medium")),
                        horizontalLine()
                      ],
                    ),

                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                            onPressed: () {

                            },
                            child: const Text(
                              'Contact Admin',
                              style: TextStyle(
                                  color: splashScreenColorTop,fontFamily: "Poppins-Bold"),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget horizontalLine() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

// navigateAndStop(context, const HomeView());



}
