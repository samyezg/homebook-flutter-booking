import 'package:flutter_riverpod/flutter_riverpod.dart';

const demoUserId = 'user-demo';

class ActiveUserIdNotifier extends Notifier<String> {
  @override
  String build() => demoUserId;

  void setId(String id) => state = id;

  void clear() => state = demoUserId;
}

final activeUserIdProvider =
    NotifierProvider<ActiveUserIdNotifier, String>(ActiveUserIdNotifier.new);
