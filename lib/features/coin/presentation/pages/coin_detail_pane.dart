import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/coin.dart';
import '../widgets/coin_detail_content.dart';

class CoinDetailPane extends StatelessWidget {
  const CoinDetailPane({
    super.key,
    required this.coin,
    required this.isLoading,
    required this.isFailure,
    required this.onRetry,
  });

  final Coin? coin;
  final bool isLoading;
  final bool isFailure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isFailure) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.somethingWentWrong,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(onPressed: onRetry, child: Text(l10n.tryAgain)),
          ],
        ),
      );
    }
    if (coin == null || coin == Coin.empty) {
      return Center(
        child: Text(
          l10n.selectCoinPrompt,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      );
    }
    return CoinDetailContent(coin: coin!);
  }
}
