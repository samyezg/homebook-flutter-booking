import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/service_card.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';
import 'package:homebook_app/features/services/presentation/services_providers.dart';
import 'package:homebook_app/features/settings/presentation/locale_notifier.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class ServiceListPage extends ConsumerStatefulWidget {
  const ServiceListPage({super.key});

  @override
  ConsumerState<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends ConsumerState<ServiceListPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(serviceSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = ref.watch(selectedCategoryProvider);
    final services = ref.watch(filteredServicesProvider);
    final localePreference = ref.watch(localePreferenceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          PopupMenuButton<String>(
            tooltip: l10n.language,
            icon: const Icon(Icons.language),
            initialValue: localePreference,
            onSelected: (value) {
              ref.read(localePreferenceProvider.notifier).setPreference(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: '', child: Text(l10n.languageSystem)),
              PopupMenuItem(value: 'en', child: Text(l10n.languageEnglish)),
              PopupMenuItem(value: 'zh', child: Text(l10n.languageChinese)),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          TextField(
            key: const ValueKey('service-search'),
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchServicesHint,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
            onChanged: (value) {
              ref.read(serviceSearchQueryProvider.notifier).setQuery(value);
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.categories,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.xs),
                  child: FilterChip(
                    key: const ValueKey('cat-all'),
                    label: Text(l10n.categoryAll),
                    selected: selected == null,
                    onSelected: (_) {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .setCategory(null);
                    },
                  ),
                ),
                for (final category in ServiceCategory.values)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: FilterChip(
                      key: ValueKey('cat-${category.id}'),
                      label: Text(
                        '${category.icon} ${l10n.serviceCategoryLabel(category)}',
                      ),
                      selected: selected == category,
                      onSelected: (_) {
                        ref
                            .read(selectedCategoryProvider.notifier)
                            .setCategory(category);
                      },
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            selected == null
                ? l10n.allServices
                : l10n.serviceCategoryLabel(selected),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.servicesCountPayOnSite(services.length),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.secondary,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (services.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Center(child: Text(l10n.noMatchingServices)),
            )
          else
            for (final service in services) ...[
              ServiceCard(
                id: service.id,
                title: service.name,
                category: service.category,
                priceLabel: service.priceLabel,
                durationLabel: l10n.serviceDurationLabel(service),
                rating: service.ratingAvg,
                ratingCount: service.ratingCount,
                onTap: () =>
                    context.push(AppRoutes.serviceDetailLocation(service.id)),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}
