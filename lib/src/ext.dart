extension MyIterable<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

extension MyString on String {
  int get parseIdOrThrow {
    final int? id = int.tryParse(this);
    if (id == null) {
      throw FormatException('Invalid input parameter \'$this\'');
    }
    return id;
  }
}
