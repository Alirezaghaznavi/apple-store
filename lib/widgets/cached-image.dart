import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  CachedImage(
      {super.key,
      required this.imageUrl,
      this.borderRadius,
      this.boxFit,
      this.width,
      this.height});

  final String imageUrl;
  final double? borderRadius;
  final BoxFit? boxFit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: boxFit,
        width: width,
        height: height,
        alignment: Alignment.center,
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
          child: Text(error),
        ),
        placeholder: (context, url) => Container(color: Colors.white),
      ),
    );
  }
}
