import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const NewsImage({
    super.key,
    required this.imageUrl,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallbackImage(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            )
          : _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    return Image.asset(
      'assets/images/no_images.png',
      fit: BoxFit.cover,
    );
  }
}
