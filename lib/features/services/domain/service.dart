import 'package:homebook_app/features/services/domain/service_category.dart';

class Service {
  const Service({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.priceCents,
    required this.durationMinutes,
    required this.providerId,
    required this.highlights,
    this.ratingAvg = 5.0,
    this.ratingCount = 0,
  });

  final String id;
  final String name;
  final ServiceCategory category;
  final String description;
  final int priceCents;
  final int durationMinutes;
  final String providerId;
  final List<String> highlights;
  final double ratingAvg;
  final int ratingCount;

  String get priceLabel => '¥${(priceCents / 100).toStringAsFixed(0)}';
}
