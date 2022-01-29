import 'package:flutter/material.dart';
import 'package:order_app/providers/authprovider.dart';
import 'package:order_app/widgets/authwidget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routename = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isloading = false;
  Future<void> _submitForm(
    String userName,
    String email,
    String password,
    String number,
    bool isLogin,
    BuildContext ctx,
  ) async {
    setState(() {
      isloading = true;
    });
    isLogin
        ? await Provider.of<AuthProvider>(ctx, listen: false)
            .logIn(email, password, ctx)
        : await Provider.of<AuthProvider>(context, listen: false)
            .signUp(userName, number, email, password, ctx);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.orange,
            Colors.pink,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Image(
              image: const AssetImage("assets/qe5gdb8igkrg58ujrqmd15gf95.png"),
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            AuthWidget(_submitForm, isloading),
          ],
        ),
      ),
    );
  }
}
