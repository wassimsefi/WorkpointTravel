import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';
class PasswordField extends StatefulWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final bool icon;
  final String hint;

  const PasswordField(
      {Key key,
      this.onChanged,
      this.icon,
      this.textEditingController,
      this.hint})
      : super(key: key);

  @override
  PasswordFieldState createState() => PasswordFieldState();
}
class PasswordFieldState extends State<PasswordField> {
  bool visible;
  @override
  void initState() {
    // TODO: implement initState
    visible = false;
  }
  @override
  Widget build(BuildContext context) {
    IconData eyeN = Icons.visibility_off_outlined;
    IconData eye = Icons.visibility_rounded;
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: widget.textEditingController,
        obscureText: !visible,
        onChanged: widget.onChanged,
        cursorColor: LightColors.kDarkBlue,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: LightColors.kgrey),
          focusColor: LightColors.kDarkBlue,
          hoverColor: Colors.white,
          fillColor: LightColors.kDarkBlue,
          hintText: widget.hint,
          icon: Icon(
            Icons.lock_outline_rounded,
            color: LightColors.kDarkBlue,
          ),
          suffixIcon: visible == false
              ? IconButton(
            icon: Icon(
              eyeN,
              color: LightColors.kDarkBlue,
            ),
            onPressed: () {
              visible = true;
              setState(() {
                visible = true;
              });
            },
          )
              : IconButton(
            icon: Icon(
              eye,
              color: LightColors.kDarkBlue,
            ),
            onPressed: () {
              setState(() {
                visible = false;
              });
            },
          ),
          focusedBorder: UnderlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: LightColors.kDarkBlue)),
          border: UnderlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: LightColors.kDarkBlue)),
        ),
      ),
    );
  }
}