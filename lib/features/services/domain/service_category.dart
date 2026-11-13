enum ServiceCategory {
  cleaning(id: 'cleaning', icon: '🏠'),
  repair(id: 'repair', icon: '🔧'),
  renovation(id: 'renovation', icon: '🎨'),
  moving(id: 'moving', icon: '📦');

  const ServiceCategory({
    required this.id,
    required this.icon,
  });

  final String id;
  final String icon;

  static ServiceCategory? byId(String id) {
    for (final item in values) {
      if (item.id == id) return item;
    }
    return null;
  }
}
