import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/validation_code.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/input_field.dart';

class Forgotpassword extends StatelessWidget {
  TextEditingController email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width/1.8,
              child: Center(
                child: Text(
                  "Enter the email address associated with your account",
                  style: TextStyle(color: Colors.black,fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: size.height/12,),
            InputField(
              hintText: "Your Email",
              textEditingController: email,
              onChanged: (value) {},
            ),
            SizedBox(height: size.height/20,),
            InkWell(
                child: Container(
                    width:180,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: LightColors.kDarkBlue,
                    ),
                    child:  Center(
                      child: AutoSizeText( "Recover",maxFontSize: 20,
                        minFontSize: 8, maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ),

              ),
              onTap:() {
                  String textEmail=this.email.text;
                  Random rn = new Random();
                  int randomNumber = 100000 + rn.nextInt(999999 - 100000);
                  Future<dynamic> forgotpassword = UserService().forgotpassword(textEmail,randomNumber.toString());
                  forgotpassword.then((value) {

                    if(value.toString()=="{error: User with that email does not exist}")
                   {
                     SweetAlert.show(context,subtitle: "email does not exist!", style: SweetAlertStyle.error);

                   }
                 else {

                    var iduser=value["message"]["_id"];
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>ValidationCode(randomNumber,iduser)));
                 }
                  });


              },
            ),
          ],
        ),
      ),
    );
  }
}
