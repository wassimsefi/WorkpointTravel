import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';

class Doodle {
  final String name;
  final String etat;
  final dynamic content;
  final dynamic Etatcontent;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  const Doodle(
      {this.name,
      this.etat,
      this.content,
      this.Etatcontent,
      this.doodle,
      this.icon,
      this.iconBackground});
}
