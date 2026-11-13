import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/features/profile/domain/app_role.dart';

class AppRoleNotifier extends Notifier<AppRole> {
  @override
  AppRole build() => AppRole.user;

  void setRole(AppRole role) => state = role;

  void toggle() {
    state = state == AppRole.user ? AppRole.provider : AppRole.user;
  }
}

final appRoleProvider =
    NotifierProvider<AppRoleNotifier, AppRole>(AppRoleNotifier.new);

/// Which provider identity the demo workbench is acting as.
class ActiveProviderIdNotifier extends Notifier<String> {
  @override
  String build() => 'prov-li';

  void setId(String id) => state = id;
}

final activeProviderIdProvider =
    NotifierProvider<ActiveProviderIdNotifier, String>(
  ActiveProviderIdNotifier.new,
);
