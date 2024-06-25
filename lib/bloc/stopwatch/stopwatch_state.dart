part of 'stopwatch_bloc.dart';

class StopwatchState {
  final int elapsedTime;
  final bool isRunning;
  final List<String> laps;

  const StopwatchState({
    required this.elapsedTime,
    this.isRunning = false,
    this.laps = const [],
  });

// emit 클래스를 사용하여 상태를 매번 새로만들어서 업데이트 함으로 copyWith 메서드로 매번 새로운 상태를 만들어서 emit할 수 있게함.
  StopwatchState copyWith({
    int? elapsedTime,
    bool? isRunning,
    List<String>? laps,
  }) {
    return StopwatchState(
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isRunning: isRunning ?? this.isRunning,
      laps: laps ?? this.laps,
    );
  }
}
