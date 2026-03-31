import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animationimage extends StatelessWidget {
  Animationimage(
      {Key? key, required this.path, required this.width, required this.height})
      : super(key: key);

  final String path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width,
      height: this.height,
      child: Center(
        child: Lottie.asset(this.path),
      ),
    );
  }
}
