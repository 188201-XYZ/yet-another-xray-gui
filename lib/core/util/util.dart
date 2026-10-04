extension CapitalizedString on String {
  String toCapitalized() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension EmptyOrNullCheck on Uri? {
  bool get isEmptyOrNull => this == null || toString().isEmpty;
}
