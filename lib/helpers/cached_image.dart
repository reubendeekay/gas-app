import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gas/helpers/button_loader.dart';
import 'package:gas/helpers/my_shimmer.dart';

Widget cachedImage(
  String url, {
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    height: height,
    width: width,
    fit: fit,
    progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        height: height,
        width: width,
        // color: Colors.grey,
        child: MyShimmer(
            child: Transform.scale(scale: 2, child: const MyLoader()))),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
