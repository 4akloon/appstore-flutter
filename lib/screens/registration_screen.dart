import 'package:appstore/screens/pages.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../auth_config.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Future signIn() async {
  //   Map<String, String> body = Map<String, String>();

  //   body.putIfAbsent("email", () => _emailController.text);
  //   body.putIfAbsent("password", () => _passwordController.text);

  //   if (_usernameController.text.isNotEmpty) {
  //     body.putIfAbsent("name", () => _usernameController.text);
  //   }

  //   var res = await http.post("$SERVER_IP/users", body: body);
  //   if (res.statusCode == 200) {
  //     try {
  //       Map<String, String> headers = res.headers;
  //       storage.write(key: 'jwtToken', value: headers['x-auth-token']);
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, HomeScreen.id, (route) => false);
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else if (res.body == "User already registered.") {
  //     showAlertDialog(context, "Пользователь с таким email уже существует",
  //         'Введите другой email.');
  //   } else {
  //     showAlertDialog(context, "Ошибка",
  //         'Проверьте правильность введенных почты и пароля.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Регистрация",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor),
              ),
              SizedBox(
                height: 40.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          cursorColor: Theme.of(context).cursorColor,
                          validator: (String value) {
                            if (value.length < 2) {
                              return "Минимальная длина имени - 2";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Имя',
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          cursorColor: Theme.of(context).cursorColor,
                          validator: (String value) {
                            if (value.length < 2) {
                              return "Минимальная длина фамилии - 2";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Фамилия',
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _usernameController,
                          cursorColor: Theme.of(context).cursorColor,
                          validator: (String value) {
                            if (value.length < 5) {
                              return "Минимальная длина имени пользователя - 5";
                            }
                            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]+")
                                .hasMatch(value)) {
                              return "A-z, 0-9";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
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
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Theme.of(context).cursorColor,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Введите email";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Введите корректный email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
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
                            if (value.length < 6) {
                              return "Минимальная длина пароля - 6";
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
                        TextFormField(
                          controller: _password2Controller,
                          cursorColor: Theme.of(context).cursorColor,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Повторно введите пароль";
                            }
                            if (_passwordController.text !=
                                _password2Controller.text) {
                              return "Пароли не совпадают";
                            }
                            return null;
                          },
                          obscureText: _isHidden ? true : false,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Повторите пароль',
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
                              if (await register(
                                    _usernameController.text,
                                    _passwordController.text,
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _emailController.text,
                                  ) ==
                                  201) {
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
                          label: Text('Зарегистрироваться'),
                        )
                      ],
                    ),
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
