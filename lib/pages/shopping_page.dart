//import 'package:cart_shopping/appAsset/app_assets.dart';
import 'package:cart_shopping/appAsset/app_style.dart';
import 'package:cart_shopping/bloc/auth_bloc.dart';
import 'package:cart_shopping/bloc/shopping_bloc.dart';
import 'package:cart_shopping/pages/next_page.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final bloc = FetchDataBloc();
  //AuthBloc authBloc = AuthBloc();
  //bool _show = false;

  /*@override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    bloc.fetchData();
    bloc.stateStream.listen((data) {
      debugPrint('hellow');
      debugPrint(data);
    });

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Home',
                style: AppStyle.h3.copyWith(color: Colors.green[900])),
          ),
          elevation: 0,
          backgroundColor: Colors.green[100],
        ),
        body: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NextPage()));
            },
            child: const Text('Go')));
  }
}
