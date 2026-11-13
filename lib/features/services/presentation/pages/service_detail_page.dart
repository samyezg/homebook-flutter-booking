import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/provider_card.dart';
import 'package:homebook_app/core/widgets/rating_stars.dart';
import 'package:homebook_app/features/services/presentation/services_providers.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class ServiceDetailPage extends ConsumerWidget {
  const ServiceDetailPage({super.key, required this.serviceId});

  final String serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final service = ref.watch(serviceByIdProvider(serviceId));

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.serviceDetailTitle)),
        body: Center(child: Text(l10n.serviceMissing)),
      );
    }

    final provider = ref.watch(providerByIdProvider(service.providerId));

    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Container(
            height: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Text(
              service.category.icon,
              style: const TextStyle(fontSize: 48),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            service.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.durationPricePayOnSite(
              l10n.serviceDurationLabel(service),
              service.priceLabel,
            ),
            style: const TextStyle(
              fontFamily: AppFonts.secondary,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          RatingStars(
            rating: service.ratingAvg,
            count: service.ratingCount,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            service.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontFamily: AppFonts.secondary,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.serviceIncludes,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final item in service.highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('·  '),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontFamily: AppFonts.secondary),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.provider,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (provider != null)
            ProviderCard(provider: provider)
          else
            Text(l10n.providerMissing),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: FilledButton(
            key: const ValueKey('book-now'),
            onPressed: () => context.push(AppRoutes.bookLocation(service.id)),
            child: Text(l10n.bookNow(service.priceLabel)),
          ),
        ),
      ),
    );
  }
}
