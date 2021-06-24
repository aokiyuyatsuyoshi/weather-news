import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class sampele1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///appbarを透明にしたやつ
Widget ClearAppBar() {
  return AppBar(
    title: Text(
      "Weather News",
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white.withOpacity(0.5),
  );
}

///背景をセットする
Widget BackgroundView() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            "https://media.istockphoto.com/videos/tropical-beach-video-id473215013?s=640x640"),
        fit: BoxFit.cover,
      ),
    ),
  );
}

///天気によりアイコンを変更する関数
Widget SwitchWeatherIcon(String weather) {
  switch (weather) {
    case "晴れ":
      return Icon(
        Icons.wb_sunny_sharp,
        color: Colors.red,
        size: 30,
      );
    case "曇り":
      return Icon(
        Icons.wb_cloudy_sharp,
        color: Colors.grey,
        size: 30,
      );
    case "雨":
      return Icon(
        Icons.wb_incandescent,
        color: Colors.blue,
        size: 30,
      );
  }
}

///指定した位置
Widget YourLocation(String place) {
  return Text(
    place,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

///その土地の現在の天気
Widget CurrentCondition(String condition) {
  return Text(
    condition,
    style: TextStyle(
      fontSize: 30,
      color: Colors.white,
    ),
  );
}

///その土地の現在の気温
Widget CurrentTemperature(String temperature) {
  return Text(
    temperature,
    style: TextStyle(
      fontSize: 80,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget CurrentMaxAndMin(int max, int min) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Text(
          "最高：${max}°",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
      Text(
        "最低：${min}°",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ],
  );
}

///よく使うdevider()
Widget DividerLine() {
  return Divider(
    height: 10,
    color: Colors.white,
  );
}

Widget WeekMaxAndMin(int max, int min) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Text(
          "${max}°",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      Text(
        "${min}°",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ],
  );
}
