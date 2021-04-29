class ActivityNotFoundException implements Exception {
  final List<String> tags;

  ActivityNotFoundException(this.tags);

  @override
  String toString() {
    return 'Activity ID not found for tag/s: ${tags.join(', ')}';
  }
}
