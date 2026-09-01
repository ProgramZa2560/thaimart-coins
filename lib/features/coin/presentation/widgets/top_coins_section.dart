import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme.dart';
import '../../data/models/coin.dart';
import 'change_badge.dart';
import 'coin_icon.dart';

class TopCoinsSection extends StatelessWidget {
  const TopCoinsSection({
    super.key,
    required this.coins,
    required this.onCoinTap,
  });

  final List<Coin> coins;
  final ValueChanged<Coin> onCoinTap;

  @override
  Widget build(BuildContext context) {
    final top3 = coins.take(3).toList();
    if (top3.length < 3) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: List.generate(top3.length, (index) {
          final coin = top3[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => onCoinTap(coin),
              child: Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : 4,
                  right: index == top3.length - 1 ? 0 : 4,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F2FA),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CoinIcon(url: coin.iconUrl, size: 36),
                    const SizedBox(height: 8),
                    Text(
                      coin.symbol,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppFormatters.formatPrice(coin.price),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ChangeBadge(change: coin.change),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
