import 'package:flutter/material.dart';

class CakeData {
  String? name;
  String? flavour;
  String? imagePath;
  String? description;
  Color? bgColor;
  Color? color;
  double? price;
  double? rating;
  bool? favouriteStatus;

  CakeData(
      {this.name,
      this.flavour,
      this.imagePath,
      this.description,
      this.bgColor,
      this.color,
      this.price,
      this.rating,
      this.favouriteStatus,});

}
