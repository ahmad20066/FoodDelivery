import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  Function submit;
  bool isLoading;
  AuthWidget(this.submit, this.isLoading);
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  TextEditingController UserNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    void trySubmit() {
      FocusScope.of(context).unfocus();
      bool isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      _form.currentState!.save();
      widget.submit(
          UserNameController.text,
          emailController.text,
          passwordController.text,
          PhoneNumberController.text,
          isLogin,
          context);
    }

    return Center(
      child: Container(
          padding: const EdgeInsets.all(8),
          //alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.7,
          height: isLogin
              ? MediaQuery.of(context).size.height * 0.3
              : MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: widget.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Form(
                      key: _form,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          if (!isLogin)
                            TextFormField(
                              controller: UserNameController,
                              decoration: const InputDecoration(
                                label: Text("UserName"),
                                icon: Icon(Icons.person),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null) {
                                  return "Please Enter a user name";
                                }
                              },
                            ),
                          TextFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                label: Text("email"),
                                icon: Icon(Icons.alternate_email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null) {
                                  return "Please Enter an email";
                                } else if (!(value.contains("@"))) {
                                  return "Please Enter a valid email";
                                }
                              }),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                label: Text("password"),
                                icon: Icon(Icons.password)),
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            validator: (value) {
                              if (value == null) {
                                return "Please enter a password";
                              } else if (value.length < 5) {
                                return "Password should contain more than 5 characters";
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          if (!isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Confirm password"),
                                icon: Icon(Icons.password),
                              ),
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null) {
                                  return "Please Confirm your password";
                                } else if (value != passwordController.text) {
                                  return "Passwords don`t match";
                                }
                              },
                            ),
                          if (!isLogin)
                            TextFormField(
                              controller: PhoneNumberController,
                              decoration: const InputDecoration(
                                label: Text("Phone number"),
                                icon: Icon(Icons.phone),
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null) {
                                  return "Please Enter a Phone number";
                                } else if (num.tryParse(value) == null) {
                                  return "Enter a valid phone number";
                                }
                              },
                            ),
                          TextButton(
                              onPressed: () {
                                trySubmit();
                              },
                              child: Text(isLogin ? "login" : "SignUp")),
                          TextButton(
                              onPressed: () {
                                emailController.clear();
                                passwordController.clear;
                                UserNameController.clear;
                                PhoneNumberController.clear;
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child:
                                  Text(isLogin ? "SignUp instead" : "Login")),
                        ],
                      )),
                )),
    );
  }
}
