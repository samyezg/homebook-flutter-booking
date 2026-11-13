class ProviderProfile {
  const ProviderProfile({
    required this.id,
    required this.name,
    required this.ratingAvg,
    required this.ratingCount,
    required this.bio,
    this.avatarEmoji = '👷',
  });

  final String id;
  final String name;
  final double ratingAvg;
  final int ratingCount;
  final String bio;
  final String avatarEmoji;

  ProviderProfile copyWith({
    double? ratingAvg,
    int? ratingCount,
  }) {
    return ProviderProfile(
      id: id,
      name: name,
      ratingAvg: ratingAvg ?? this.ratingAvg,
      ratingCount: ratingCount ?? this.ratingCount,
      bio: bio,
      avatarEmoji: avatarEmoji,
    );
  }
}
