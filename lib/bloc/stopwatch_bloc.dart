import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/utils.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

// StopwatchBloc 클래스를 정의합니다.
class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Stopwatch _stopwatch = Stopwatch(); // 스톱워치 인스턴스를 생성합니다.
  final Duration _tick = const Duration(milliseconds: 10); // 틱 간격을 설정합니다.

  // StopwatchBloc 생성자에서 초기 상태를 설정하고 이벤트 핸들러를 등록합니다.
  StopwatchBloc() : super(const StopwatchState(elapsedTime: 0)) {
    on<StopwatchStarted>(_onStarted); // 스톱워치 시작 이벤트 핸들러 등록
    on<StopwatchStopped>(_onStopped); // 스톱워치 중지 이벤트 핸들러 등록
    on<StopwatchReset>(_onReset); // 스톱워치 초기화 이벤트 핸들러 등록
    on<StopwatchTicked>(_onTicked); // 스톱워치 틱 이벤트 핸들러 등록
    on<StopwatchRecordLap>(_onRecordLap); // 스톱워치 랩 기록 이벤트 핸들러 등록
  }

  // 스톱워치 시작 이벤트 핸들러
  void _onStarted(StopwatchStarted event, Emitter<StopwatchState> emit) {
    _stopwatch.start(); // 스톱워치를 시작합니다.
    emit(state.copyWith(isRunning: true));
    _tickTimer(); // 타이머를 시작합니다.
  }

  // 스톱워치 중지 이벤트 핸들러
  void _onStopped(StopwatchStopped event, Emitter<StopwatchState> emit) {
    _stopwatch.stop(); // 스톱워치를 중지합니다.
    emit(state.copyWith(isRunning: false));
  }

  // 스톱워치 초기화 이벤트 핸들러
  void _onReset(StopwatchReset event, Emitter<StopwatchState> emit) {
    _stopwatch.reset(); // 스톱워치를 초기화합니다.
    emit(const StopwatchState(elapsedTime: 0, laps: [])); // 상태를 초기화합니다.
  }

  // 스톱워치 틱 이벤트 핸들러
  void _onTicked(StopwatchTicked event, Emitter<StopwatchState> emit) {
    emit(StopwatchState(
        elapsedTime: _stopwatch.elapsedMilliseconds,
        laps: state.laps)); // 경과 시간을 업데이트합니다.
  }

  // 스톱워치 랩 기록 이벤트 핸들러
  void _onRecordLap(StopwatchRecordLap event, Emitter<StopwatchState> emit) {
    final String lap = formatElapsedTime(state.elapsedTime);
    emit(state.copyWith(laps: [...state.laps, lap])); // 랩을 기록합니다.
  }

  void _tickTimer() {
    Timer.periodic(_tick, (timer) {
      if (!_stopwatch.isRunning) {
        timer.cancel();
      } else {
        add(StopwatchTicked(
            elapsedMilliseconds: _stopwatch.elapsedMilliseconds));
      }
    });
  }
}
