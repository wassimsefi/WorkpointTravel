import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/UserServices.dart';

class PieChart extends CustomPainter {
  PieChart({@required this.categories, @required this.width});

  final List<Category> categories;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    categories.forEach((expense) => total += expense.amount);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.amount / total * 2 * pi;
      // Used modulo/remainder to catch use case if there is more than 6 colours
      paint.color = kNeumorphicColors.elementAt(index % categories.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      // The new startRadian starts from where the previous sweepRadian.
      // Example, a circle perimeter is 10.
      // Category A takes a startRadian 0 and ends at sweepRadian 5.
      // Category B takes the startRadian where Category A left off, which is 5
      // and ends at sweepRadian 7.
      // Category C takes the startRadian where Category B left off, which is 7
      // and so on.
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category {
  Category(this.name, {@required this.amount});

   String name;
   double amount;
}
List<Category> kCategories = [
    //Category('On site', amount: 300.00),
  //Category('WFH', amount: 150.00),


];

 var kNeumorphicColors = [
  Color.fromRGBO(82, 98, 255, 1), //  rgb(82, 98, 255)
  Color.fromRGBO(46, 198, 255, 1),

//  rgb(252, 91, 57)// rgb(46, 198, 255)



 //rgb(139, 135, 130)
];