import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/new_password.dart';

class ValidationCode extends StatefulWidget {
int code ;
String iduser;
ValidationCode(this.code ,this.iduser,{Key key}) : super(key: key);

  @override
  _ValidationCodeState createState() => _ValidationCodeState();
}

class _ValidationCodeState extends State<ValidationCode> {
  StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
String validateCode;
  bool hasError = false;
  @override
  void initState() {
    validateCode = widget.code.toString().trim();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  // snackBar Widget


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Email Verification",style: TextStyle(fontSize: 25),),
          SizedBox(height: size.height/30,),

          Text("Enter received code",style: TextStyle(fontSize:17)),
          SizedBox(height: size.height/10,),
          Center(
            child: Container(child:
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              obscureText: true,
              obscuringCharacter: '*',
              obscuringWidget: Image.asset("assets/images/androidicon.png"
              ),
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v.length < 3) {
                  return "COMPLETE YOUR CODE";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(

                inactiveFillColor: LightColors.kPalePink,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) async {
                        if (currentText.toString() !=validateCode) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                        } else {
                        setState(
                        () {
                        hasError = false;
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Validated code"),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        },
                        );
                        await Future.delayed(new Duration(seconds: 1),() async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>NewPassword(widget.iduser.toString())));
                        });
                        }
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            )),
          ),
        ],
      ),
    );
  }
}