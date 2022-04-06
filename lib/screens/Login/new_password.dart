import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/password_field.dart';

class NewPassword extends StatelessWidget {
  String idUser;
  NewPassword(this.idUser ,{Key key}) : super(key: key);


  TextEditingController password = new TextEditingController();
  TextEditingController repeatpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top:size.height/20 ),
        child: Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: size.width/1.8,
              child: Center(
                child: Text(
                  "Enter a new password",
                  style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: size.height/12,),
            PasswordField(
              textEditingController: password,
              hint:"New password",
              onChanged: (value) {},
            ),
            PasswordField(
              textEditingController: repeatpassword,
              hint: "Repeat new password ",
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
                    child: AutoSizeText( "Submit",maxFontSize: 20,
                      minFontSize: 8, maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                ),

              ),
              onTap:() {

              if(password.text==repeatpassword.text && password.text.isNotEmpty && repeatpassword.text.isNotEmpty){
                Future<dynamic> newpassword = UserService().newpassword(password.text,this.idUser.toString());
                newpassword.then((value) async {
                  if(value["message"]=="newpassword updated succesfully")
                  {
                   await SweetAlert.show(context,subtitle: "newpassword updated succesfully", style: SweetAlertStyle.success);
                    await Future.delayed(new Duration(seconds: 2),() async {
                      DateTime selectedDate=  DateTime.now();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>SignInScreen(selectedDate)));
                    });

                  }
                  else {
                    SweetAlert.show(context,subtitle: "Error", style: SweetAlertStyle.error);
                  }
                });

              }

              else{
                SweetAlert.show(context,subtitle: "password doesn't match ", style: SweetAlertStyle.error);


              }

            }
            ),
          ],
      ),
        ),),
    );
  }
}
