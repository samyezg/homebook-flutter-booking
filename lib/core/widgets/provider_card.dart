import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/rating_stars.dart';
import 'package:homebook_app/features/providers/domain/provider_profile.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key, required this.provider});

  final ProviderProfile provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('provider-${provider.id}'),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.surfaceVariant,
            child: Text(
              provider.avatarEmoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: const TextStyle(
                    fontFamily: AppFonts.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                RatingStars(
                  rating: provider.ratingAvg,
                  count: provider.ratingCount,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  provider.bio,
                  style: const TextStyle(
                    fontFamily: AppFonts.secondary,
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
