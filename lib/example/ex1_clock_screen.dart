import 'package:flutter/material.dart';

// ClockScreen 클래스를 StatelessWidget을 상속받아 정의합니다.
class ClockScreen extends StatelessWidget {
  // const 생성자를 사용하여 불변 위젯임을 표시합니다.
  const ClockScreen({super.key});

  // build 메서드를 오버라이드하여 위젯을 구성합니다.
  @override
  Widget build(BuildContext context) => Scaffold(
        // Scaffold 위젯을 사용하여 기본적인 앱 구조를 만듭니다.
        appBar: AppBar(
          // AppBar 위젯을 사용하여 상단 앱 바를 만듭니다.
          title: const Text('Clock Screen'), // 앱 바의 제목을 설정합니다.
          backgroundColor: Colors.deepPurple, // 앱 바의 배경색을 설정합니다.
        ),
        // 본문 중앙에 StreamBuilder를 사용하여 시간을 표시합니다.
        body: Center(
          child: StreamBuilder(
            // Stream.periodic을 사용하여 1초마다 현재 시간을 스트림에 전달합니다.
            stream: Stream.periodic(
              const Duration(seconds: 1), // 1초 간격으로 타이머를 설정합니다.
              (_) => DateTime.now(), // 현재 시간을 스트림에 전달합니다.
            ),
            // 빌더를 사용하여 스트림에서 전달된 데이터를 화면에 표시합니다.
            builder: (context, snapshot) {
              // 스트림이 활성 상태일 때 시간을 표시합니다.
              if (snapshot.connectionState == ConnectionState.active) {
                DateTime? currentTime = snapshot.data; // 현재 시간을 가져옵니다.
                return Text(
                  // 시간을 텍스트로 표시합니다.
                  '${currentTime?.hour}:${currentTime?.minute}:${currentTime?.second}',
                  style: const TextStyle(
                      fontSize: 50, // 텍스트 크기를 설정합니다.
                      color: Colors.deepPurple, // 텍스트 색상을 설정합니다.
                      fontWeight: FontWeight.bold), // 텍스트 두께를 설정합니다.
                );
              }
              // 스트림이 비활성 상태일 때 로딩 인디케이터를 표시합니다.
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
}
