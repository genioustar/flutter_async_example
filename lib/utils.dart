String formatElapsedTime(int milseconds) {
  final miliseconds = (milseconds % 1000).floor();
  final seconds = milseconds ~/ 1000;
  final minutes = seconds ~/ 60;
  final hours = minutes ~/ 60;
  final String time =
      '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}:${miliseconds.toString().padLeft(3, '0')}';

  return time;
}
