import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vato/screens/User/Chart/categories_row.dart';
import 'package:vato/screens/User/Chart/pie_chart_view.dart';


class MontlyExpensesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
           // Spacer(),
            SizedBox(
              height: height * 0.43,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height * 0.065),
                    Text(
                      'Monthly Expenses',
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          CategoriesRow(),
                          PieChartView(),
                        ],
                      ),
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
}