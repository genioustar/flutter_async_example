import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/bloc/stopwatch/stopwatch_bloc.dart';
import 'package:stream_example/utils.dart';

// StopWatchScreen 클래스를 StatefulWidget을 상속받아 정의합니다.
class BlocStopWatchScreen extends StatelessWidget {
  const BlocStopWatchScreen({super.key});

  // createState 메서드를 오버라이드하여 상태를 생성합니다.
  // build 메서드를 오버라이드하여 위젯을 구성합니다.
  @override
  Widget build(BuildContext context) => Scaffold(
        // 상단 앱 바를 설정합니다.
        appBar: AppBar(
          title: const Text('Stop Watch Screen'), // 앱 바의 제목을 설정합니다.
          backgroundColor: Colors.deepPurple, // 앱 바의 배경색을 설정합니다.
        ),
        // 본문 중앙에 StreamBuilder를 사용하여 시간을 표시합니다.
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: BlocBuilder<StopwatchBloc, StopwatchState>(
                builder: (context, state) {
                  return Text(
                    formatElapsedTime(state.elapsedTime),
                    style: const TextStyle(fontSize: 48),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<StopwatchBloc, StopwatchState>(
                builder: (context, state) => ListView.builder(
                  itemCount: state.laps.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text('Lap ${index + 1}: ${state.laps[index]}'),
                  ),
                ),
              ),
            ),
          ],
        ),
        // FloatingActionButton을 중앙 하단에 배치합니다.
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 타이머 시작 버튼을 설정합니다.
              FloatingActionButton(
                heroTag: 'start',
                onPressed: () => context
                    .read<StopwatchBloc>()
                    .add(const StopwatchStarted()), // 버튼을 누르면 타이머를 시작합니다.
                tooltip: 'Start Timer', // 툴팁을 설정합니다.
                child: const Icon(Icons.play_arrow), // 아이콘을 설정합니다.
              ),
              // 타이머 멈춤 버튼을 설정합니다.
              FloatingActionButton(
                heroTag: 'stop',
                onPressed: () => context
                    .read<StopwatchBloc>()
                    .add(const StopwatchStopped()), // 버튼을 누르면 타이머를 멈춥니다.
                tooltip: 'Stop Timer', // 툴팁을 설정합니다.
                child: const Icon(Icons.stop), // 아이콘을 설정합니다.
              ),
              // 타이머 초기화 버튼을 설정합니다.
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: () => context
                    .read<StopwatchBloc>()
                    .add(const StopwatchReset()), // 버튼을 누르면 타이머를 초기화합니다.
                tooltip: 'Reset Timer', // 툴팁을 설정합니다.
                child: const Icon(Icons.refresh), // 아이콘을 설정합니다.
              ),
              FloatingActionButton(
                heroTag: 'recordLap',
                onPressed: () => context
                    .read<StopwatchBloc>()
                    .add(const StopwatchRecordLap()), // 버튼을 누르면 lap을 기록합니다..
                tooltip: 'Record Lap', // 툴팁을 설정합니다.
                child: const Icon(Icons.flag_outlined), // 아이콘을 설정합니다.
              ),
            ],
          ),
        ),
      );
}
