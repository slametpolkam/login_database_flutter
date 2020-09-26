// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_register/constants.dart';
import 'package:login_register/screens/dasboard_view.dart';
import 'package:login_register/screens/register_view.dart';
// import 'package:login_register/screens/dasboard_view.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/LoginPage";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _iconLogin(),
                  _titleDescription(),
                  _textField(context),
                  // _buildButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _iconLogin() {
  return Image.asset(
    "assets/images/logo.png",
    height: 150.0,
    width: 150.0,
  );
}

Widget _titleDescription() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16.0),
      ),
      Text(
        "Masuk Kedalam Sistem",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.0),
      ),
      Text(
        "Silahkan Login Kedalam Sistem",
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _textField(BuildContext context) {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var pengguna;

  // Showing CircularProgressIndicator.

  login() async {
    // Getting value from Controller
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // SERVER LOGIN API URL
    var url = 'http://192.168.100.31:81/index.php/pengguna';
    // POST KE SISTEM
    var response = await http.post(url,
        // headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
        body: {'username': username, 'password': password});

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'login berhasil') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      // Showing Alert Dialog with Response JSON Message.
      Alert(
        context: context,
        type: AlertType.warning,
        title: "MAAF NAMA PENGGUNA & SANDI TIDAK TERSEDIA",
        desc: "${message}", //"Silahkan Kembali",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
    }
  }

  void setIntoSharedPreferences() async {
    String username = _usernameController.text.trim();
    pengguna = username;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("pengguna", pengguna);
  }

  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 12.0),
      ),
      TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField,
              width: 1.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
          ),
          hintText: "Username",
          hintStyle: TextStyle(color: ColorPalette.hintColor),
        ),
        style: TextStyle(color: Colors.white),
        autofocus: false,
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.0),
      ),
      TextFormField(
        controller: _passwordController,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField,
              width: 1.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
          ),
          hintText: "Password",
          hintStyle: TextStyle(color: ColorPalette.hintColor),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: true,
        autofocus: false,
      ),
      Padding(
        padding: EdgeInsets.only(top: 16.0),
      ),
      FlatButton(
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        // ignore: missing_return
        onPressed: () {
          login();
          setIntoSharedPreferences();
          // pengguna = _usernameController
          //     .text; //Mengisi variabel pengguna dengan inputan pengguna
          // if (_usernameController.text.trim() == "admin" &&
          //     _passwordController.text.trim() == "admin") {
          //   setIntoSharedPreferences(); //memanggil method setIntoSharedPreferences
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => Dashboard()),
          //   );
          // } else {
          //   /**
          //    * Membuat Alert jika gagal login
          //    */
          //   return showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         content: Text("Login Gagal " + pengguna),
          //       );
          //     },
          //   );
          // }
        },
      ),
      Padding(
        padding: EdgeInsets.only(top: 16.0),
      ),
      Text(
        'or',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
      FlatButton(
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, RegisterPage.routeName);
        },
      ),
    ],
  );
}
