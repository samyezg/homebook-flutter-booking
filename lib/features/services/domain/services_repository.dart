import 'package:homebook_app/features/providers/domain/provider_profile.dart';
import 'package:homebook_app/features/services/domain/service.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';

abstract class ServicesRepository {
  List<Service> listServices({ServiceCategory? category, String query = ''});

  Service? getService(String id);

  ProviderProfile? getProvider(String id);

  List<ProviderProfile> listProviders();

  /// Recalculates running average after a new star rating.
  ProviderProfile applyReviewRating(String providerId, int rating);
}
