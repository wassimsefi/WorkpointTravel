import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/screens/Login/LoginWidget.dart';

class SignInScreen extends StatelessWidget {
  DateTime selectedDate;
  SignInScreen(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: Login(selectedDate),
    );
  }
}
