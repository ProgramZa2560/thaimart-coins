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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          AppFormatters.formatChange(change),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            height: 1.0,
            leadingDistribution: TextLeadingDistribution.even,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
