import 'package:appstore/auth_config.dart';
import 'package:appstore/screens/pages.dart';
import 'package:appstore/screens/registration_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Future logIn() async {
  //   var res = await http.post("$SERVER_IP/auth", body: {
  //     "username": _emailController.text,
  //     "password": _passwordController.text
  //   });
  //   if (res.statusCode == 200) {
  //     try {
  //       var token = jsonDecode(res.body);
  //       storage.write(key: 'jwtToken', value: token['token']);
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, PagesScreen.id, (route) => false);
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     showAlertDialog(context, "Пользователь не найден",
  //         'Проверьте правильность введенных почты и пароля.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: animation.value,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Column(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Theme.of(context).cursorColor,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Введите имя пользователя";
                                }
                                if (value.length < 5) {
                                  return "Миннимальная длина 5 символов";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: 'Имя пользователя',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              cursorColor: Theme.of(context).cursorColor,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Введите пароль";
                                }

                                if (value.length < 5) {
                                  return "Миннимальная длина 5 символов";
                                }
                                return null;
                              },
                              obscureText: _isHidden ? true : false,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Пароль',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: _isHidden
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            FloatingActionButton.extended(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (await logIn(
                                        _usernameController.text,
                                        _passwordController.text,
                                      ) ==
                                      200) {
                                    await AuthConfig().init();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PagesScreen(),
                                        ),
                                        (route) => false);
                                  }
                                } else {
                                  print("Unsuccessfull");
                                }
                              },
                              label: Text('Войти'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ещё нет аккаунта?",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "Создать",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
