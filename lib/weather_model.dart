class Weather {
  final double? temp;//현재 온도
  final int? tempMin;//최저 온도
  final int? tempMax;//최고 온도
  final String weatherMain;//흐림정도
  final int? code;//흐림정도의 id(icon 작업시 필요)

  Weather({
    this.temp,
    this.tempMin,
    this.tempMax,
    required this.weatherMain,
    this.code,
  });
}