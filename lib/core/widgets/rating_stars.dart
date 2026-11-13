import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.count,
    this.size = 16,
  });

  final double rating;
  final int? count;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: size, color: AppColors.statusPending),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontFamily: AppFonts.secondary,
            fontSize: size * 0.85,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: AppSpacing.xxs),
          Text(
            '($count)',
            style: TextStyle(
              fontFamily: AppFonts.secondary,
              fontSize: size * 0.75,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
