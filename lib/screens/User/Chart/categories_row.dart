import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/screens/User/Chart/pie_chart.dart';
import 'package:vato/services/UserServices.dart';

class CategoriesRow extends StatefulWidget {
  const CategoriesRow({
    Key key,
  }) : super(key: key);

  @override
  _CategoriesRowState createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  UserService _userService = new UserService();
  Future<SharedPreferences> _prefs;
String idUser;
String StartDate;
String EndDate;
String tokenLogin;
  @override
  void initState() {
    // TODO: implement initState
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        idUser = prefs.get("_id");
        tokenLogin = prefs.get("token");
      });
      DateTime now = DateTime.now();
      StartDate = DateTime(now.year, now.month, 1).toString();
      //StartDate=DateTime.now().add(Duration(days: -10)).toString();
      int days=Jiffy().daysInMonth;
     EndDate= DateTime.now().add(Duration(days: days-1)).toString();
      print(StartDate.toString());
      print(EndDate.toString());
      kCategories=[];
      _userService.Get_NBR_Reservation(tokenLogin,idUser,StartDate,EndDate).then((value) {
        print(value.toString());

        setState(() {
          kCategories.add(Category("On Site",amount :double.tryParse(value["data"].toString())));
        });

        _userService.Get_NBR_WFH(tokenLogin,idUser,StartDate,EndDate).then((value) {
          print(value.toString());

          setState(() {
            kCategories.add(Category("WFH",amount :double.tryParse(value["data"].toString())));
          });
        });
      });

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var category in kCategories)
            ExpenseCategory(
                text: category.name, index: kCategories.indexOf(category),value :category.amount)
        ],
      ),
    );
  }
}

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({
    Key key,
    @required this.index,
    @required this.text,
    @required this.value,
  }) : super(key: key);

  final int index;
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
              kNeumorphicColors.elementAt(index % kNeumorphicColors.length),
            ),
          ),
          SizedBox(width: 20),
          Text(text.capitalize()),
          SizedBox(width: 10),

          Text(value.toString(),style: TextStyle(color: Colors.black54,fontSize: 13),)

        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}