import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/coin.dart';
import 'change_badge.dart';
import 'coin_icon.dart';

class CoinDetailContent extends StatelessWidget {
  const CoinDetailContent({super.key, required this.coin});

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = coin.color != null
        ? Color(int.parse(coin.color!.replaceFirst('#', '0xff')))
        : AppColors.accent;
    final hasWebsite = coin.websiteUrl != null && coin.websiteUrl!.isNotEmpty;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: CoinIcon(url: coin.iconUrl, size: 36),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: coin.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: ' (${coin.symbol})',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: '${l10n.price}: ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: AppFormatters.formatPrice(coin.price),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text.rich(
                      TextSpan(
                        text: '${l10n.marketCap}: ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: AppFormatters.formatMarketCap(coin.marketCap),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ChangeBadge(change: coin.change),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            (coin.description == null || coin.description!.isEmpty)
                ? l10n.noDescription
                : coin.description!,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
          if (hasWebsite) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => launchUrl(
                Uri.parse(coin.websiteUrl!),
                mode: LaunchMode.externalApplication,
              ),
              child: Text(
                l10n.readMore,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
