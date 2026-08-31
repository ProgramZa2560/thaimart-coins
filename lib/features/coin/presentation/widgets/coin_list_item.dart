import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme.dart';
import '../../data/models/coin.dart';
import 'change_badge.dart';
import 'coin_icon.dart';

class CoinListItem extends StatelessWidget {
  const CoinListItem({super.key, required this.coin, this.onTap});

  final Coin coin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            CoinIcon(url: coin.iconUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.symbol,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppFormatters.formatMarketCap(coin.marketCap),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppFormatters.formatPrice(coin.price),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                ChangeBadge(change: coin.change),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
