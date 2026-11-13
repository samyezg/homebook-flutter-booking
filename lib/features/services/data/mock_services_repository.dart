import 'package:homebook_app/features/providers/domain/provider_profile.dart';
import 'package:homebook_app/features/services/data/mock_services_seed.dart';
import 'package:homebook_app/features/services/domain/service.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';
import 'package:homebook_app/features/services/domain/services_repository.dart';

class MockServicesRepository implements ServicesRepository {
  MockServicesRepository({
    List<Service>? services,
    List<ProviderProfile>? providers,
  })  : _services = List.unmodifiable(services ?? MockServicesSeed.services),
        _providers = {
          for (final p in providers ?? MockServicesSeed.providers) p.id: p,
        };

  final List<Service> _services;
  final Map<String, ProviderProfile> _providers;

  @override
  List<Service> listServices({ServiceCategory? category, String query = ''}) {
    final q = query.trim().toLowerCase();
    return [
      for (final service in _services)
        if (category == null || service.category == category)
          if (q.isEmpty ||
              service.name.toLowerCase().contains(q) ||
              service.description.toLowerCase().contains(q))
            service,
    ];
  }

  @override
  Service? getService(String id) {
    for (final service in _services) {
      if (service.id == id) return service;
    }
    return null;
  }

  @override
  ProviderProfile? getProvider(String id) => _providers[id];

  @override
  List<ProviderProfile> listProviders() => _providers.values.toList(growable: false);

  @override
  ProviderProfile applyReviewRating(String providerId, int rating) {
    if (rating < 1 || rating > 5) {
      throw ArgumentError('Rating must be 1-5');
    }
    final current = _providers[providerId];
    if (current == null) {
      throw StateError('Provider not found');
    }
    final nextCount = current.ratingCount + 1;
    final nextAvg =
        ((current.ratingAvg * current.ratingCount) + rating) / nextCount;
    final updated = current.copyWith(
      ratingAvg: double.parse(nextAvg.toStringAsFixed(2)),
      ratingCount: nextCount,
    );
    _providers[providerId] = updated;
    return updated;
  }
}
