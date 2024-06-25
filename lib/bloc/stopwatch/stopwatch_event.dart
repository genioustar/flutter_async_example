part of 'stopwatch_bloc.dart';

sealed class StopwatchEvent {
  const StopwatchEvent();
}

final class StopwatchStarted extends StopwatchEvent {
  const StopwatchStarted();
}

final class StopwatchStopped extends StopwatchEvent {
  const StopwatchStopped();
}

final class StopwatchReset extends StopwatchEvent {
  const StopwatchReset();
}

final class StopwatchTicked extends StopwatchEvent {
  final int elapsedMilliseconds;

  const StopwatchTicked({required this.elapsedMilliseconds});
}

final class StopwatchRecordLap extends StopwatchEvent {
  const StopwatchRecordLap();
}
