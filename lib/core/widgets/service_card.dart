import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/rating_stars.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.id,
    required this.title,
    required this.category,
    required this.priceLabel,
    required this.durationLabel,
    required this.rating,
    this.ratingCount,
    this.onTap,
  });

  final String id;
  final String title;
  final ServiceCategory category;
  final String priceLabel;
  final String durationLabel;
  final double rating;
  final int? ratingCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        key: ValueKey('service-card-$id'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: AppSizes.cardImage,
                height: AppSizes.cardImage,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(category.icon, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: AppFonts.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '$durationLabel · $priceLabel',
                      style: const TextStyle(
                        fontFamily: AppFonts.secondary,
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    RatingStars(rating: rating, count: ratingCount),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
