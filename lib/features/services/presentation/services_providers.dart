import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/features/providers/domain/provider_profile.dart';
import 'package:homebook_app/features/services/data/mock_services_repository.dart';
import 'package:homebook_app/features/services/domain/service.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';
import 'package:homebook_app/features/services/domain/services_repository.dart';

final servicesRepositoryProvider = Provider<ServicesRepository>((ref) {
  return MockServicesRepository();
});

class CatalogRevisionNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final catalogRevisionProvider =
    NotifierProvider<CatalogRevisionNotifier, int>(CatalogRevisionNotifier.new);

class SelectedCategoryNotifier extends Notifier<ServiceCategory?> {
  @override
  ServiceCategory? build() => null;

  void setCategory(ServiceCategory? category) => state = category;
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, ServiceCategory?>(
  SelectedCategoryNotifier.new,
);

class ServiceSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

final serviceSearchQueryProvider =
    NotifierProvider<ServiceSearchQueryNotifier, String>(
  ServiceSearchQueryNotifier.new,
);

final filteredServicesProvider = Provider<List<Service>>((ref) {
  final repo = ref.watch(servicesRepositoryProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(serviceSearchQueryProvider);
  return repo.listServices(category: category, query: query);
});

final serviceByIdProvider = Provider.family<Service?, String>((ref, id) {
  return ref.watch(servicesRepositoryProvider).getService(id);
});

final providerByIdProvider =
    Provider.family<ProviderProfile?, String>((ref, id) {
  ref.watch(catalogRevisionProvider);
  return ref.watch(servicesRepositoryProvider).getProvider(id);
});

final providersListProvider = Provider<List<ProviderProfile>>((ref) {
  ref.watch(catalogRevisionProvider);
  return ref.watch(servicesRepositoryProvider).listProviders();
});
