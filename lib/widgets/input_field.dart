import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';
class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  const InputField({
    Key key,
    this.hintText,
    this.textEditingController,
    this.icon = Icons.account_circle_outlined,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
            style: TextStyle(color: Colors.black),
            onChanged: onChanged,
            cursorColor: LightColors.kdBlue,
            controller: textEditingController,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: LightColors.kgrey),
              icon: Icon(icon, color: LightColors.kDarkBlue),
              hintText: hintText,
              focusedBorder: UnderlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: LightColors.kDarkBlue)),
              border: UnderlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: LightColors.kDarkBlue)),
            )));
  }
}