import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme.dart';

class ChangeBadge extends StatelessWidget {
  const ChangeBadge({super.key, required this.change});

  final num change;

  @override
  Widget build(BuildContext context) {
    final isUp = change >= 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isUp ? AppColors.greenBackground : AppColors.redBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward : Icons.arrow_downward,
            size: 10,
            color: isUp ? AppColors.green : AppColors.red,
          ),
          const SizedBox(width: 2),
          Text(
            AppFormatters.formatChange(change),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isUp ? AppColors.green : AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
