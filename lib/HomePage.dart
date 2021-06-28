import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/model.dart';
import 'model/model.dart';
import 'model/model.dart';
import 'model/model.dart';
import 'widget/widget.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'API/API.dart';

final Global_Provider = ChangeNotifierProvider((ref) => Provider());

class Provider with ChangeNotifier {
  Get_Adress(String AdressNumber) async {
    String PrefectureToTown = await GetAdress.GetAdress_City(AdressNumber);
    notifyListeners();
    if (PrefectureToTown != "error") {
      return PrefectureToTown;
    } else {
      return "不正な郵便番号です";
    }
  }

  Get_Current_Weather(String AddressNumber) async {
    NowWeather = await weather.Current_Weather(AddressNumber);
    notifyListeners();
    return NowWeather;
  }

  Get_Hour_Weather(double latitude, double longitude) async {
    HourWeather = await weather.GetHourlyWeatherMethod(
        latitude: latitude, longitude: longitude);
    notifyListeners();
    return HourWeather;
  }

  Get_Daily_Weather(double latitude, double longitude) async {
    DailyWeather = await weather.GetWeeklyWeatherMethod(
        latitude: latitude, longitude: longitude);
    notifyListeners();
    return DailyWeather;
  }
}

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Adress = useState("-");
    final Weather = useState(NowWeather);
    final hourWeather = useState(HourWeather);
    final dailyWeather = useState(DailyWeather);
    final background = useState(0);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            BackgroundView(background.value),
            ListView(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      YourLocation(Adress.value),
                      CurrentCondition(Weather.value.condition),
                      CurrentTemperature("${Weather.value.temperature}"),
                      CurrentMaxAndMin(Weather.value.max_temperature,
                          Weather.value.min_temperature),
                      DividerLine(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: hourWeather.value == null
                            ? Container()
                            : Row(
                                children: hourWeather.value.map((weather) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${DateFormat("H").format(weather.time)}時",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Image.network(
                                            "https://openweathermap.org/img/wn/${weather.icon}.png"),
                                        Text(
                                          "${weather.temperature}°",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      DividerLine(),
                      dailyWeather.value == null
                          ? Container()
                          : Column(
                              children: DailyWeather.map((weather) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${Week[weather.time.weekday - 1]}曜日",
                                        style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image.network(
                                          "https://openweathermap.org/img/wn/${weather.icon}.png"),
                                      WeekMaxAndMin(weather.max_temperature,
                                          weather.min_temperature),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Flexible(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "郵便番号を入力してください",
                                hintStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.white24),
                              ),
                              onSubmitted: (value) async {
                                Adress.value = await context
                                    .read(Global_Provider)
                                    .Get_Adress(value);
                                Weather.value = await context
                                    .read(Global_Provider)
                                    .Get_Current_Weather(value);

                                hourWeather.value = await context
                                    .read(Global_Provider)
                                    .Get_Hour_Weather(Weather.value.latitude,
                                        Weather.value.longitude);

                                dailyWeather.value = await context
                                    .read(Global_Provider)
                                    .Get_Daily_Weather(Weather.value.latitude,
                                        Weather.value.longitude);
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
