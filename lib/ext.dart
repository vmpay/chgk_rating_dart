extension MyIterable<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
