import 'package:cart_shopping/appAsset/app_assets.dart';
import 'package:cart_shopping/appAsset/app_style.dart';
import 'package:cart_shopping/bloc/auth_bloc.dart';
import 'package:cart_shopping/bloc/shopping_bloc.dart';
import 'package:cart_shopping/pages/dialog/loading_dialog.dart';
import 'package:cart_shopping/pages/dialog/msg_dialog.dart';
import 'package:cart_shopping/pages/register_page.dart';
import 'package:cart_shopping/pages/shopping_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = FetchDataBloc();
  final authBloc = AuthBloc();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _show = false;

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bloc.fetchData();
    //bloc.stateStream.listen((data) {
    //  debugPrint('hellow');
    //debugPrint(data);
    //});
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Login',
                style: AppStyle.h3.copyWith(color: Colors.green[900])),
          ),
          elevation: 0,
          backgroundColor: Colors.green[100],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.green[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: const Color(0xffaaaaaa)),
                      shape: BoxShape.circle,
                      color: Colors.blue[100]),
                  child: Image.asset(AppAssets.logo1)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Amber food',
                    style: AppStyle.h3.copyWith(color: Colors.green[900])),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Hello\nWelcome back!', style: AppStyle.h3),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: TextField(
                  controller: _emailController,
                  style: AppStyle.h5.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: AppStyle.h5
                          .copyWith(fontSize: 15, color: Colors.black54)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                        controller: _passController,
                        style: AppStyle.h5.copyWith(color: Colors.black),
                        obscureText: _show ? false : true,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: AppStyle.h5
                                .copyWith(fontSize: 15, color: Colors.black54)),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _show = !_show;
                            });
                          },
                          child: _show
                              ? const Text('HIDE',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold))
                              : const Text('SHOW',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)))
                    ],
                  )),
              ElevatedButton(
                onPressed: _onSignIn,
                child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('SIGN IN',
                        style: TextStyle(fontSize: 24, color: Colors.white70))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RichText(
                    text: TextSpan(
                        text: "If you don't have account, you can ",
                        style: const TextStyle(
                            fontSize: 16.0, color: Color(0xff666666)),
                        children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                          text: 'Sign up for a new account!',
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.blue))
                    ])),
              )
            ],
          ),
        ));
  }

  void _onSignIn() {
    String email = _emailController.text;
    String pass = _passController.text;

    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(email, pass, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ShoppingPage()),
          (route) => false);
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, 'Sign In', msg);
    });
  }
}
