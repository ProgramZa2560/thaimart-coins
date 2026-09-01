import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants.dart';
import '../../../../core/theme.dart';
import '../../../../l10n/app_localizations.dart';

class InviteFriendsTile extends StatelessWidget {
  const InviteFriendsTile({super.key});

  static const iconColor = AppColors.inviteIcon;
  static const headColor = AppColors.inviteHead;
  static const subColor = AppColors.inviteSub;
  static const backgroundColor = AppColors.inviteBg;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => SharePlus.instance.share(
        ShareParams(text: AppConstants.inviteUrl),
      ),
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                SizedBox(
                  width: 46,
                  height: 46,
                  child: Center(
                    child: Icon(
                      Icons.person_add_alt_1,
                      color: iconColor,
                      size: 28,
                    ),
                  ),
                ),
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
                            color: headColor,
                          ),
                        ),
                      const SizedBox(height: 1),
                      Text(
                        l10n.inviteSubtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: subColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, indent: 70),
          ],
        ),
      ),
    );
  }
}
