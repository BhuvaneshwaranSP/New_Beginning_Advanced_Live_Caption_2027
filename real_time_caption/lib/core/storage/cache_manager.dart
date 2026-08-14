class CacheManager {
  final Map<String, Object?> _cache = <String, Object?>{};
  Object? get(String key) => _cache[key];
  void put(String key, Object? value) => _cache[key] = value;
  void clear() => _cache.clear();
}
