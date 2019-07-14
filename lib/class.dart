import 'package:flutter/material.dart';
class GameButton{
  final id;
  String text;
  bool enabled;
  Color bg;
  GameButton({this.id, this.text="", this.bg=Colors.grey, this.enabled= true});
}