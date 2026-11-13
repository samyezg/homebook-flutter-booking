import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/app/config/app_environment.dart';

final appEnvironmentProvider = Provider<AppEnvironment>((ref) {
  return AppEnvironment.fromDefines();
});
