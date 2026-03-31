import 'package:flutter/material.dart';
import 'dart:typed_data';

class NetworkImageCustom extends StatelessWidget {
  NetworkImageCustom(
      {Key? key,
      required this.imageUrl,
      required this.isChooseImage,
      required this.imageMemo,
      required this.dowloadImage,
      required this.onGetImage})
      : super(key: key);

  final String imageUrl;
  final bool isChooseImage;
  final Uint8List imageMemo;
  final Uint8List dowloadImage;
  final GestureTapCallback onGetImage;

  @override
  Widget build(BuildContext context) {
    if (!this.isChooseImage && this.imageUrl == "")
      return GestureDetector(
          onTap: this.onGetImage,
          child: Container(
            color: Colors.greenAccent,
          ));

    return GestureDetector(
      onTap: onGetImage,
      child:
          Image.memory(this.isChooseImage ? this.imageMemo : this.dowloadImage),
    );
  }
}
