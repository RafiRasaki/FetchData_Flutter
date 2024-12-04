import 'dart:convert';

import 'package:d_method/d_method.dart';

import '../models/game.dart';
import 'package:http/http.dart' as http;

class GameSource{
  static Future<List<Game>?> getLiveGame() async{
    String url = 'https://www.freetogame.com/api/games';
    try {
    final response = await http.get(Uri.parse(url));
    DMethod.logResponse(response);

     if(response.statusCode==200){
       List list = jsonDecode(response.body);
       List<Game> games = list.map((e) => Game.fromJson(Map.from(e))).toList();
       return games;
     } else{
       return null;
     }
    } catch (e) {
      DMethod.log(e.toString());
      return null;
    }
  }
}