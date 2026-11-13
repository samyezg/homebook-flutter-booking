import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/services/data/mock_services_repository.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

void main() {
  final repo = MockServicesRepository();
  final zh = lookupAppLocalizations(const Locale('zh'));
  final en = lookupAppLocalizations(const Locale('en'));

  test('seed has six services across four categories', () {
    final all = repo.listServices();
    expect(all.length, 6);
    expect(
      ServiceCategory.values.every(
        (c) => all.any((s) => s.category == c),
      ),
      isTrue,
    );
  });

  test('filters by category and query', () {
    final cleaning = repo.listServices(category: ServiceCategory.cleaning);
    expect(cleaning.length, 2);
    expect(cleaning.every((s) => s.category == ServiceCategory.cleaning), isTrue);

    final pipe = repo.listServices(query: 'Plumbing');
    expect(pipe, hasLength(1));
    expect(pipe.first.name, 'Plumbing Repair');
  });

  test('resolves service and provider', () {
    final service = repo.getService('svc-deep-clean');
    expect(service, isNotNull);
    expect(service!.priceLabel, '¥88');
    expect(zh.serviceDurationLabel(service), '2小时');
    expect(en.serviceDurationLabel(service), '2h');

    final paint = repo.getService('svc-paint');
    expect(zh.serviceDurationLabel(paint!), '1天');
    expect(en.serviceDurationLabel(paint), '1d');

    final provider = repo.getProvider(service.providerId);
    expect(provider?.name, 'Master Zhang');
  });
}
