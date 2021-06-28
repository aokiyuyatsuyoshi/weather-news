import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

///実際にAPIを使用して郵便番号から住所の一部を取得するクラス
class GetAdress {
  ///引数Sring型AddressNumber　返り値Stringのメソッド
  static Future<String> GetAdress_City(String AddressNumber) async {
    ///実際のリクエストURL
    String URL =
        "https://zipcloud.ibsnet.co.jp/api/search?zipcode=${AddressNumber}";

    ///ここでGETしてjsonを取得する
    var result = await get(Uri.parse(URL));

    ///jsonはMap型かつ<string, int>, <string, double>のように第二引数がdynamicになっている。ここでmap型に変換
    Map<String, dynamic> APIData = jsonDecode(result.body);

    if (APIData["results"] != null) {
      ///県を取得(例：福岡県)
      String address1 = APIData["results"][0]["address1"];

      ///市を取得(例：北九州市)
      String address2 = APIData["results"][0]["address2"];

      ///街を取得(例：上美唄町協和)
      String address3 = APIData["results"][0]["address3"];

      ///県・市・街を合体(例：福岡県北九州市箕面市三田)
      String PrefectureToTown_Adress = address1 + address2 + address3;
      return PrefectureToTown_Adress;
    } else {
      return "error";
    }

    ///正しく文字列が取得できていればPrefectureToTown_Adressを返す
  }
}
