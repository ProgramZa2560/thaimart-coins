import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants.dart';
import '../../../../core/theme.dart';
import '../../../../l10n/app_localizations.dart';

class InviteFriendsTile extends StatelessWidget {
  const InviteFriendsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => SharePlus.instance.share(
        ShareParams(text: AppConstants.inviteUrl),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(Icons.person_add_alt_1, color: AppColors.accent, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.inviteFriends,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.inviteSubtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 68),
        ],
      ),
    );
  }
}
