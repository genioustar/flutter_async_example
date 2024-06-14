import 'dart:async';

import 'package:flutter/material.dart';

// StopWatchScreen 클래스를 StatefulWidget을 상속받아 정의합니다.
class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  // createState 메서드를 오버라이드하여 상태를 생성합니다.
  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

// _StopWatchScreenState 클래스를 정의하여 상태를 관리합니다.
class _StopWatchScreenState extends State<StopWatchScreen> {
  // Stopwatch 인스턴스를 생성합니다.
  final Stopwatch _stopwatch = Stopwatch();
  // 타이머 간격을 10밀리초로 설정합니다.
  final Duration _timerInterval = const Duration(milliseconds: 10);
  late Timer _timer;
  late StreamController<int> _timerStreamController;

  // 타이머를 시작하는 메서드입니다.
  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start(); // 스톱워치를 시작합니다.
      // 타이머를 설정하여 주기적으로 Stream에 경과 시간을 추가합니다.
      _timer = Timer.periodic(_timerInterval, (Timer timer) {
        _timerStreamController.add(_stopwatch.elapsedMilliseconds);
      });
    }
  }

  // 타이머를 멈추는 메서드입니다.
  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop(); // 스톱워치를 멈춥니다.
      _timer.cancel(); // 타이머를 취소합니다.
    }
  }

  // 타이머를 초기화하는 메서드입니다.
  void _resetTimer() {
    _stopwatch.reset(); // 스톱워치를 초기화합니다.
    _timerStreamController.add(0); // 초기화된 시간을 Stream에 추가합니다.
  }

  // 위젯이 처음 생성될 때 호출되는 메서드입니다.
  @override
  void initState() {
    super.initState();
    // StreamController를 초기화합니다.
    _timerStreamController = StreamController<int>();
  }

  // 위젯이 삭제될 때 호출되는 메서드입니다.
  @override
  void dispose() {
    _timer.cancel(); // 타이머를 취소합니다.
    _timerStreamController.close(); // StreamController를 닫습니다.
    super.dispose();
  }

  // build 메서드를 오버라이드하여 위젯을 구성합니다.
  @override
  Widget build(BuildContext context) => Scaffold(
        // 상단 앱 바를 설정합니다.
        appBar: AppBar(
          title: const Text('Stop Watch Screen'), // 앱 바의 제목을 설정합니다.
          backgroundColor: Colors.deepPurple, // 앱 바의 배경색을 설정합니다.
        ),
        // 본문 중앙에 StreamBuilder를 사용하여 시간을 표시합니다.
        body: Center(
          child: StreamBuilder<int>(
            stream: _timerStreamController.stream, // Stream을 설정합니다.
            builder: (context, snapshot) {
              // Stream에서 전달된 시간을 받아서 표시합니다.
              final miliseconds = snapshot.data ?? 0;
              final seconds = miliseconds ~/ 1000;
              final minutes = seconds ~/ 60;
              final hours = minutes ~/ 60;
              final String time =
                  '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}:${(miliseconds % 1000).toString().padLeft(3, '0')}';
              return Text(
                time, // 시간을 텍스트로 표시합니다.
                style: const TextStyle(
                  fontSize: 48, // 텍스트 크기를 설정합니다.
                  fontWeight: FontWeight.w500, // 텍스트 두께를 설정합니다.
                  color: Colors.deepPurple, // 텍스트 색상을 설정합니다.
                ),
              );
            },
          ),
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
                onPressed: _startTimer, // 버튼을 누르면 타이머를 시작합니다.
                tooltip: 'Start Timer', // 툴팁을 설정합니다.
                child: const Icon(Icons.play_arrow), // 아이콘을 설정합니다.
              ),
              // 타이머 멈춤 버튼을 설정합니다.
              FloatingActionButton(
                heroTag: 'stop',
                onPressed: _stopTimer, // 버튼을 누르면 타이머를 멈춥니다.
                tooltip: 'Stop Timer', // 툴팁을 설정합니다.
                child: const Icon(Icons.stop), // 아이콘을 설정합니다.
              ),
              // 타이머 초기화 버튼을 설정합니다.
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: _resetTimer, // 버튼을 누르면 타이머를 초기화합니다.
                tooltip: 'Reset Timer', // 툴팁을 설정합니다.
                child: const Icon(Icons.refresh), // 아이콘을 설정합니다.
              ),
            ],
          ),
        ),
      );
}

// void main() {
//   runApp(const MaterialApp(
//     home: StopWatchScreen(),
//   ));
// }
