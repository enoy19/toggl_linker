extension DurationExtension on Duration {
  Duration roundUp({Duration delta = const Duration(minutes: 15)}) {
    return Duration(
      milliseconds:
          this.inMilliseconds + this.inMilliseconds % delta.inMilliseconds,
    );
  }
}
