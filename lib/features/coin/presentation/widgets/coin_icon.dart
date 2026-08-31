import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinIcon extends StatelessWidget {
  const CoinIcon({super.key, required this.url, this.size = 40});

  final String url;
  final double size;

  bool get _isSvg => url.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => const SizedBox(),
      );
    }
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Icon(
        Icons.circle,
        size: size,
        color: Colors.grey.shade300,
      ),
    );
  }
}
