import 'package:homebook_app/features/providers/domain/provider_profile.dart';
import 'package:homebook_app/features/services/domain/service.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';

/// Canonical catalog seed is **English** (GitHub / Fiverr gallery).
/// UI chrome stays en/zh via ARB; city may keep Kunming as a real locale.
abstract final class MockServicesSeed {
  static const providers = <ProviderProfile>[
    ProviderProfile(
      id: 'prov-zhang',
      name: 'Master Zhang',
      ratingAvg: 4.9,
      ratingCount: 128,
      bio: 'Ten years in home care — deep cleaning and home organization.',
      avatarEmoji: '🧹',
    ),
    ProviderProfile(
      id: 'prov-li',
      name: 'Master Li',
      ratingAvg: 4.8,
      ratingCount: 86,
      bio: 'Licensed plumbing & electrical repairs. On-time visits.',
      avatarEmoji: '🔧',
    ),
    ProviderProfile(
      id: 'prov-wang',
      name: 'Wang · Paint',
      ratingAvg: 4.7,
      ratingCount: 42,
      bio: 'Interior refresh and partial painting. Local Kunming crew.',
      avatarEmoji: '🎨',
    ),
    ProviderProfile(
      id: 'prov-chen',
      name: 'Master Chen',
      ratingAvg: 4.6,
      ratingCount: 55,
      bio: 'Residential moves and furniture disassembly. Per-truck quotes available.',
      avatarEmoji: '🚚',
    ),
  ];

  static const services = <Service>[
    Service(
      id: 'svc-deep-clean',
      name: 'Deep Cleaning',
      category: ServiceCategory.cleaning,
      description:
          'Whole-home deep clean — ideal before move-in or holiday hosting.',
      priceCents: 8800,
      durationMinutes: 120,
      providerId: 'prov-zhang',
      ratingAvg: 4.8,
      ratingCount: 128,
      highlights: [
        'Living & bedrooms',
        'Kitchen clean',
        'Bathroom sanitize',
      ],
    ),
    Service(
      id: 'svc-daily-clean',
      name: 'Daily Cleaning',
      category: ServiceCategory.cleaning,
      description: 'Routine upkeep to keep the home tidy.',
      priceCents: 4800,
      durationMinutes: 60,
      providerId: 'prov-zhang',
      ratingAvg: 4.7,
      ratingCount: 96,
      highlights: ['Floor dusting', 'Surface wipe-down', 'Trash removal'],
    ),
    Service(
      id: 'svc-pipe-repair',
      name: 'Plumbing Repair',
      category: ServiceCategory.repair,
      description: 'Leaks, clogs, and fitting swaps — on-site diagnosis.',
      priceCents: 12000,
      durationMinutes: 60,
      providerId: 'prov-li',
      ratingAvg: 4.9,
      ratingCount: 86,
      highlights: [
        'On-site diagnosis',
        'Common parts on hand',
        'Minor fixes same visit',
      ],
    ),
    Service(
      id: 'svc-elec-repair',
      name: 'Electrical Repair',
      category: ServiceCategory.repair,
      description: 'Outlets, breakers, and lighting circuit checks.',
      priceCents: 15000,
      durationMinutes: 60,
      providerId: 'prov-li',
      ratingAvg: 4.8,
      ratingCount: 64,
      highlights: [
        'Power-safe workflow',
        'Circuit testing',
        'Transparent quote',
      ],
    ),
    Service(
      id: 'svc-paint',
      name: 'Interior Painting',
      category: ServiceCategory.renovation,
      description:
          'Single room or partial wall refresh (materials billed separately).',
      priceCents: 200000,
      durationMinutes: 24 * 60,
      providerId: 'prov-wang',
      ratingAvg: 4.7,
      ratingCount: 42,
      highlights: [
        'Surface prep',
        'Two coats latex',
        'Edge cleanup',
      ],
    ),
    Service(
      id: 'svc-moving',
      name: 'Moving Help',
      category: ServiceCategory.moving,
      description:
          'Same-city residential move with basic hauling (note oversized items).',
      priceCents: 30000,
      durationMinutes: 120,
      providerId: 'prov-chen',
      ratingAvg: 4.6,
      ratingCount: 55,
      highlights: [
        'Boxes BYO or rental',
        'Basic furniture teardown',
        'Elevator booking tips',
      ],
    ),
  ];
}
