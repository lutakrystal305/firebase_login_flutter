import 'package:cart_shopping/bloc/shopping_bloc.dart';
import 'package:cart_shopping/state/data_state.dart';
import 'package:cart_shopping/value/item_value.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  FetchDataBloc fBloc = FetchDataBloc();

  @override
  Widget build(BuildContext context) {
    fBloc.stateStream.listen((data) {
      debugPrint('hellow');
      debugPrint('data: ' + data);
    });
    return StreamBuilder(
        stream: fBloc.stateStream,
        builder: (context, snapshot) {
          // ignore: avoid_print
          print('snapshot: ' + snapshot.data.toString());
          //print(fBloc.stateStream.st)

          return const Center(
            child: Text('hello'),
          );
        });
  }
}
