import 'package:cart_shopping/appAsset/app_assets.dart';
import 'package:cart_shopping/appAsset/app_style.dart';
import 'package:cart_shopping/bloc/auth_bloc.dart';
import 'package:cart_shopping/pages/dialog/loading_dialog.dart';
import 'package:cart_shopping/pages/dialog/msg_dialog.dart';
import 'package:cart_shopping/pages/shopping_page.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = AuthBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _show = false;
  bool _show1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.green,
        ),
        body: Container(
            color: Colors.green[100],
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            constraints: const BoxConstraints.expand(),
            child: SingleChildScrollView(
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
                    child: Image.asset(AppAssets.logo2)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Sign Up',
                      style: AppStyle.h3.copyWith(color: Colors.green[900])),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: StreamBuilder(
                      stream: authBloc.nameStream,
                      builder: (context, snapshot) => TextField(
                            controller: _nameController,
                            style: AppStyle.h5.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                labelText: 'USERNAME',
                                labelStyle: AppStyle.h5.copyWith(
                                    fontSize: 15, color: Colors.black54)),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: StreamBuilder(
                      stream: authBloc.phoneStream,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _phoneController,
                          style: AppStyle.h5.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelText: 'PHONE NUMBER',
                              labelStyle: AppStyle.h5.copyWith(
                                  fontSize: 15, color: Colors.black54)),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: StreamBuilder(
                      stream: authBloc.emailStream,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _emailController,
                          style: AppStyle.h5.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelText: 'EMAIL',
                              labelStyle: AppStyle.h5.copyWith(
                                  fontSize: 15, color: Colors.black54)),
                        );
                      }),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        StreamBuilder(
                            stream: authBloc.passStream,
                            builder: (context, snapshot) {
                              return TextField(
                                controller: _passController,
                                style:
                                    AppStyle.h5.copyWith(color: Colors.black),
                                obscureText: _show ? false : true,
                                decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null,
                                    labelText: 'PASSWORD',
                                    labelStyle: AppStyle.h5.copyWith(
                                        fontSize: 15, color: Colors.black54)),
                              );
                            }),
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
                Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          style: AppStyle.h5.copyWith(color: Colors.black),
                          obscureText: _show1 ? false : true,
                          decoration: InputDecoration(
                              labelText: 'Enter your PASSWORD AGAIN',
                              labelStyle: AppStyle.h5.copyWith(
                                  fontSize: 15, color: Colors.black54)),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _show1 = !_show1;
                              });
                            },
                            child: _show1
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
                  onPressed: _onSignUp,
                  child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Text('SIGN UP',
                          style:
                              TextStyle(fontSize: 24, color: Colors.white70))),
                ),
              ],
            ))));
  }

  void _onSignUp() {
    var isValid = authBloc.isValid(_nameController.text, _emailController.text,
        _passController.text, _phoneController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, 'Loading.....');
      authBloc.signUp(_emailController.text, _passController.text,
          _nameController.text, _phoneController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ShoppingPage()),
            (route) => false);
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign-In", msg);
      });
    }
  }
}
