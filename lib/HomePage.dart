import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/model.dart';
import 'widget/widget.dart';
import 'package:intl/intl.dart';

final counterProvider = ChangeNotifierProvider((ref) => CounterNotifier());

class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(ProviderScope(child: HomePage()));
}

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = useState(0);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
//        appBar: ClearAppBar(),
//        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            BackgroundView(),
            ListView(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      YourLocation("北九州市"),
                      CurrentCondition(NowWeather.condition),
                      CurrentTemperature("${NowWeather.temperature}"),
                      CurrentMaxAndMin(NowWeather.max_temperature,
                          NowWeather.min_temperature),
                      DividerLine(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: HourWeather.map((weather) {
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
                                  Text(
                                    "${weather.percent_rain}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SwitchWeatherIcon("${weather.condition}"),
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
                      Column(
                        children: DailyWeather.map((weather) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${Week[weather.time.weekday - 1]}曜日",
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                  ),
                                ),
                                SwitchWeatherIcon(weather.condition),
                                WeekMaxAndMin(weather.max_temperature,
                                    weather.min_temperature),
                              ],
                            ),
                          );
                        }).toList(),
                      )
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
