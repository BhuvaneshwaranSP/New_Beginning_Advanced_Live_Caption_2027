class LocalStorage {
  final Map<String, Object?> _memory = <String, Object?>{};
  Object? read(String key) => _memory[key];
  void write(String key, Object? value) => _memory[key] = value;
  void remove(String key) => _memory.remove(key);
  void clear() => _memory.clear();
}
