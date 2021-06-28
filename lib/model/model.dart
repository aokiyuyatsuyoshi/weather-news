import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:async';

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

  String icon;

  ///降水確率
  int percent_rain = 0;

  weather(
      {this.temperature,
      this.max_temperature,
      this.min_temperature,
      this.condition,
      this.longitude,
      this.latitude,
      this.icon,
      this.time,
      this.percent_rain});

  static Future<List<weather>> GetWeeklyWeatherMethod(
      {double latitude, double longitude}) async {
    String URL =
        "https://api.openweathermap.org/data/2.5/onecall?lat=${latitude}&lon=${longitude}&exclude=minutely&appid=efb774a3dc315a31d05cc20f1079cd94&units=metric&lang=ja";
    var result = await get(Uri.parse(URL));
    Map<String, dynamic> APIDATA = jsonDecode(result.body);
    List<dynamic> DailyWeather = APIDATA["daily"];
    List<weather> DailyWeatherList = DailyWeather.map((APIDATA) {
      return weather(
        time: DateTime.fromMillisecondsSinceEpoch(APIDATA["dt"] * 1000),
        icon: APIDATA["weather"][0]["icon"],
        max_temperature: APIDATA["temp"]["max"].toInt(),
        min_temperature: APIDATA["temp"]["min"].toInt(),
      );
    }).toList();
    print("最高気温");
    print(DailyWeatherList[0].max_temperature);
    print("最低気温");
    print(DailyWeatherList[0].min_temperature);
    return DailyWeatherList;
  }

  static Future<List<weather>> GetHourlyWeatherMethod(
      {double latitude, double longitude}) async {
    String URL =
        "https://api.openweathermap.org/data/2.5/onecall?lat=${latitude}&lon=${longitude}&exclude=minutely&appid=efb774a3dc315a31d05cc20f1079cd94&units=metric&lang=ja";
    var result = await get(Uri.parse(URL));
    Map<String, dynamic> APIDATA = jsonDecode(result.body);
    List<dynamic> hourWeather = APIDATA["hourly"];
    List<weather> HourWeatherList = hourWeather.map((APIDATA) {
      return weather(
        time: DateTime.fromMillisecondsSinceEpoch(APIDATA["dt"] * 1000),
        temperature: APIDATA["temp"].toInt(),
        icon: APIDATA["weather"][0]["icon"],
      );
    }).toList();

    return HourWeatherList;
  }

  ///現在の天気を取得する。引数：郵便番号
  static Future<weather> Current_Weather(String AddressNumber) async {
    /// "-"が含まれていなかったら挿入する(例：1111111→111-1111)
    if (AddressNumber.contains("-")) {
    } else {
      AddressNumber =
          AddressNumber.substring(0, 3) + "-" + AddressNumber.substring(3);
    }

    ///実際のURL
    String URL =
        "https://api.openweathermap.org/data/2.5/weather?zip=${AddressNumber},JP&appid=efb774a3dc315a31d05cc20f1079cd94&units=metric&lang=ja&exclude=minutely";
    var result = await get(Uri.parse(URL));

    ///jsonはMap型かつ<string, int>, <string, double>のように第二引数がdynamicになっている。ここでmap型に変換
    Map<String, dynamic> APIdata = jsonDecode(result.body);

    ///入力値がエラーだった場合
    if (APIdata["cod"] == "404") {
      return null;
    } else {
      weather nowWeather = weather(
        condition: APIdata["weather"][0]["description"],
        temperature: APIdata["main"]["temp"].toInt(),
        max_temperature: APIdata["main"]["temp_max"].toInt(),
        min_temperature: APIdata["main"]["temp_min"].toInt(),
        longitude: APIdata["coord"]["lon"],
        latitude: APIdata["coord"]["lat"],
      );
      return nowWeather;
    }
  }
}

///現在の天気の初期値は全て0にする
weather NowWeather = weather(
  temperature: 0,
  condition: "0",
  max_temperature: 0,
  min_temperature: 0,
);

List<weather> HourWeather;

List<weather> DailyWeather;

List<String> Week = ["月", "火", "水", "木", "金", "土", "日"];
