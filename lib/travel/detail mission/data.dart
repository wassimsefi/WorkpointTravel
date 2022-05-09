import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';

class Doodle {
  final String name;
  final String etat;
  final List<String> content;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  const Doodle(
      {this.name,
      this.etat,
      this.content,
      this.doodle,
      this.icon,
      this.iconBackground});
}
