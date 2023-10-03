class CacheClient {
  final Map<String, Object?> _cache;
  CacheClient() : _cache = <String, Object>{};
  T? read<T extends Object>(String key) {
    return _cache[key] as T?;
  }

  void write<T>(String key, T value) {
    _cache[key] = value;
  }
}
