class weather {
  ///気温
  int temperature = 0;

  ///最高気温
  int max_temperature = 0;

  ///最低気温
  int min_temperature = 0;

  ///天気（晴れや雨、曇りなど）
  String condition = "";

  ///緯度軽度
  double longitude = 0.0;
  double latitude = 0.0;

  ///日付
  DateTime time;

  ///降水確率
  int percent_rain = 0;

  weather(
      {this.temperature,
      this.max_temperature,
      this.min_temperature,
      this.condition,
      this.longitude,
      this.latitude,
      this.time,
      this.percent_rain});
}

weather NowWeather = weather(
  temperature: 20,
  condition: "晴れ",
  max_temperature: 27,
  min_temperature: 17,
);

List<weather> HourWeather = [
  weather(
    temperature: 10,
    condition: "晴れ",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 0),
  ),
  weather(
    temperature: 20,
    condition: "曇り",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 1),
  ),
  weather(
    temperature: 30,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 2),
  ),
  weather(
    temperature: 10,
    condition: "晴れ",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 0),
  ),
  weather(
    temperature: 20,
    condition: "曇り",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 1),
  ),
  weather(
    temperature: 30,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 2),
  ),
  weather(
    temperature: 10,
    condition: "晴れ",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 0),
  ),
  weather(
    temperature: 20,
    condition: "曇り",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 1),
  ),
  weather(
    temperature: 30,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 2),
  ),
  weather(
    temperature: 10,
    condition: "晴れ",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 0),
  ),
  weather(
    temperature: 20,
    condition: "曇り",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 1),
  ),
  weather(
    temperature: 30,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 25, 2),
  ),
];

List<weather> DailyWeather = [
  weather(
    max_temperature: 30,
    min_temperature: 20,
    condition: "晴れ",
    percent_rain: 0,
    time: DateTime(2021, 6, 25),
  ),
  weather(
    max_temperature: 31,
    min_temperature: 22,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 26),
  ),
  weather(
    max_temperature: 33,
    min_temperature: 24,
    condition: "曇り",
    percent_rain: 0,
    time: DateTime(2021, 6, 27),
  ),
  weather(
    max_temperature: 30,
    min_temperature: 20,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 28),
  ),
  weather(
    max_temperature: 30,
    min_temperature: 20,
    condition: "曇り",
    percent_rain: 0,
    time: DateTime(2021, 6, 29),
  ),
  weather(
    max_temperature: 30,
    min_temperature: 20,
    condition: "雨",
    percent_rain: 0,
    time: DateTime(2021, 6, 30),
  ),
];

List<String> Week = ["月", "火", "水", "木", "金", "土", "日"];
