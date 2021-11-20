import 'dart:async';
import 'dart:convert';

import 'package:cart_shopping/state/data_state.dart';
import 'package:cart_shopping/value/item_value.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchDataBloc {
  var client = http.Client();
  final stateController = StreamController<String>.broadcast();
  Stream get stateStream => stateController.stream;
  void fetchData() async {
    var url = Uri.parse('https://music-be.herokuapp.com/');
    var response = await http.get(url);
    debugPrint('${response.statusCode}');
    //int statusCode = response.statusCode;
    /*var json = response.body;
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    final data = parsed.map<ItemModel>((x) => ItemModel.fromJson(x)).toList();
    stateController.sink.add(DataState(data));
    //debugPrint(json);*/
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
      print(response.body);
      //final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      // ignore: avoid_print
      //print(parsed);
      //final data = parsed.map<ItemModel>((x) => ItemModel.fromJson(x)).toList();
      //debugPrint('$data');
      //stateController.sink.add(DataState(data));
      stateController.sink.add('https://music-be.herokuapp.com/');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
//}
  }

  void dispose() {
    stateController.close();
  }
}
