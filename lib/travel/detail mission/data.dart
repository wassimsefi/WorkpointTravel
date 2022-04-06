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

const List<Doodle> doodles = [
  Doodle(
      name: "Draft",
      etat: "Done",
      content:[],
      doodle:
      "https://www.google.com/logos/doodles/2016/abd-al-rahman-al-sufis-azophi-1113th-birthday-5115602948587520-hp2x.jpg",
      icon: Icon(Icons.done, color: Colors.white),
      iconBackground: LightColors.kDarkBlue),
  Doodle(
      name: "Validation",
      etat: "Done",
      content:["My Requests"  ,  "Partner" ,  "Facility My Requests"],
           doodle:
      "https://www.google.com/logos/doodles/2015/abu-al-wafa-al-buzjanis-1075th-birthday-5436382608621568-hp2x.jpg",
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      iconBackground: LightColors.kDarkBlue),
  Doodle(
      name: "Processing ",
      etat: "In progress",
      content:["Transport" , "Hotel"  , "Visa" , "Per diem" , "Vaccine"],
     doodle:
      "https://lh3.googleusercontent.com/ZTlbHDpH59p-aH2h3ggUdhByhuq1AfviGuoQpt3QqaC7bROzbKuARKeEfggkjRmAwfB1p4yKbcjPusNDNIE9O7STbc9C0SAU0hmyTjA=s660",
      icon: Icon(
        Icons.lock_clock_outlined,
        color: Colors.white,
        size: 32.0,
      ),
      iconBackground: LightColors.kDarkBlue),
  Doodle(
      name: "Ending",
      etat: "Ending",
      content:[],
      doodle:
      "https://lh3.googleusercontent.com/bFwiXFZEum_vVibMzkgPlaKZMDc66W-S_cz1aPKbU0wyNzL_ucN_kXzjOlygywvf6Bcn3ipSLTsszGieEZTLKn9NHXnw8VJs4-xU6Br9cg=s660",
      icon: Icon(
        Icons.radio_button_unchecked,
        color: Colors.white,
        size:15,
      ),
      iconBackground: Colors.grey),

];