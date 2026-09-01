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

  static const _nameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const _symbolStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  List<InlineSpan> _buildTitleSpans() {
    final name = coin.name.trim();
    final symbol = coin.symbol.trim();
    final color = _titleColor;
    if (name.isEmpty) {
      return [
        TextSpan(text: symbol, style: _nameStyle.copyWith(color: color)),
      ];
    }
    if (symbol.isEmpty) {
      return [TextSpan(text: name, style: _nameStyle.copyWith(color: color))];
    }
    return [
      TextSpan(text: name, style: _nameStyle.copyWith(color: color)),
      TextSpan(text: ' ($symbol)', style: _symbolStyle),
    ];
  }

  Color get _titleColor {
    final c = coin.color;
    if (c == null || c.isEmpty) return Colors.black;
    var hex = c.replaceFirst('#', '');
    if (hex.length == 3) {
      hex = hex.split('').map((ch) => '$ch$ch').join();
    }
    if (hex.length != 6) return Colors.black;
    final value = int.tryParse('0xff$hex');
    if (value == null) return Colors.black;
    return Color(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasWebsite = coin.websiteUrl != null && coin.websiteUrl!.isNotEmpty;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CoinIcon(url: coin.iconUrl, size: 64),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: _buildTitleSpans(),
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
                              color: Color(0xFF6D6A6F),
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
                              color: Color(0xFF6D6A6F),
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
                    color: Color(0xFF66AAF4),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF66AAF4),
                  ),
                ),
            ),
          ],
        ],
      ),
    );
  }
}
