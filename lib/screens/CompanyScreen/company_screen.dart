import 'package:animated_progress_button/animated_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/services/CompanyService.dart';
import 'package:vato/widgets/input_field.dart';

class CompanyScreen extends StatelessWidget {
  TextEditingController Code = new TextEditingController();
  final animatedButtonController = AnimatedButtonController();
DateTime selectedDate;
  @override
  Widget build(BuildContext contextc) {
    return Scaffold(body:Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context)
    {
      return    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InputField(
          hintText: "Company Code",
          textEditingController: Code,
          icon: Icons.apartment_outlined,
          onChanged: (value) {},
        ),
        AnimatedButton(
          color: LightColors.kBlue,
          text: 'Log in',
          controller: animatedButtonController,
          onPressed: () async {
            print(Code.text);
            CompanyService().getCompany(Code.text).then((value) async {
              if(value["status"]==400){
                await Future.delayed(Duration(seconds: 2));
                animatedButtonController.completed();
                animatedButtonController.reset();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Comapny does not exist',
                      style: TextStyle(color: Colors.red),
                    )));
              }
              else
                {
                  await Future.delayed(
                      Duration(seconds: 2)); // simulated your API request.
                  animatedButtonController.completed();

                  await Future.delayed(Duration(seconds: 1));
                  animatedButtonController.reset();
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Done',
                        style: TextStyle(color: Colors.green),
                      )));
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignInScreen(selectedDate)));
                }
            });
            /// calling your API here and wait for the response.
// call to reset button
          },
        ),
      ],
    );
    }));

  /*  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InputField(
          hintText: "Company Code",
          textEditingController: Code,
          icon: Icons.apartment_outlined,
          onChanged: (value) {},
        ),
        AnimatedButton(
          color: LightColors.kBlue,
          text: 'Log in',
          controller: animatedButtonController,
          onPressed: () async {
            print(Code.text);
            CompanyService().getCompany(Code.text).then((value) async {
              if(value["status"]==400){
                await Future.delayed(Duration(seconds: 2));
                animatedButtonController.completed();

                animatedButtonController.reset();
                Scaffold.of(contextc).showSnackBar(SnackBar(
                    content: Text(
                      'Comapny does not exist',
                      style: TextStyle(color: Colors.red),
                    )));
              }
              else
                {
                  await Future.delayed(
                      Duration(seconds: 5)); // simulated your API request.
                  animatedButtonController.completed();

                  await Future.delayed(Duration(seconds: 2));
                  animatedButtonController.reset();
                  Scaffold.of(contextc).showSnackBar(SnackBar(
                      content: Text(
                        'Done',
                        style: TextStyle(color: Colors.green),
                      )));

                }
            });
            /// calling your API here and wait for the response.
// call to reset button
          },
        ),
      ],
    )*/

  }
}
