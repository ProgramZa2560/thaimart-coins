import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme.dart';

class ChangeBadge extends StatelessWidget {
  const ChangeBadge({super.key, required this.change});

  final num change;

  @override
  Widget build(BuildContext context) {
    final isUp = change >= 0;
    final color = isUp ? AppColors.green : AppColors.red;
    final borderColor = isUp ? AppColors.greenBorder : AppColors.redBorder;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward : Icons.arrow_downward,
            size: 10,
            color: Colors.white,
          ),
          const SizedBox(width: 2),
          Text(
            AppFormatters.formatChange(change),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
