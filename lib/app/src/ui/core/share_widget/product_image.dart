import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
      ),
      fit: BoxFit.cover,
    );
  }
}
