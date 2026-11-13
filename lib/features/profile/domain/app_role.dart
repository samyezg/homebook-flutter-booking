enum AppRole {
  user(id: 'user'),
  provider(id: 'provider');

  const AppRole({required this.id});

  final String id;
}
