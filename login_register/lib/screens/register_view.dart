import 'package:flutter/material.dart';
import 'package:login_register/constants.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/RegisterPage";
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _iconRegistrasi(),
            _titleDescription(),
            _textField(context),
          ],
        ),
      ),
    );
  }
}

Widget _iconRegistrasi() {
  return Image.asset(
    "assets/images/logo.png",
    width: 150.0,
    height: 150.0,
  );
}

Widget _titleDescription() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16.0),
      ),
      Text(
        "Registrasi",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      Text(
        "Silahkan Mendaftar Kursus di Uda Coding",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _textField(BuildContext context) {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  registrasi() async {
    // Getting value from Controller
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // SERVER LOGIN API URL
    var url = 'http://192.168.100.31:81/index.php/pengguna/daftar';
    // POST KE SISTEM
    var response = await http.post(url,
        // headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
        body: {'username': username, 'password': password});

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'tidak diizinkan') {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "PENAMBAHAN DATA GAGAL",
        desc: "Duplikat Nama Pengguna", //"Silahkan Kembali",
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
    } else {
      // Showing Alert Dialog with Response JSON Message.
      Alert(
        context: context,
        type: AlertType.warning,
        title: "PENAMBAHAN DATA BERHASIL",
        desc: "Silahkan Login", //"Silahkan Kembali",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
    }
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
          hintStyle: TextStyle(color: Colors.white),
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
              width: 3.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
          ),
          hintText: "Passwrod",
          hintStyle: TextStyle(color: ColorPalette.hintColor),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: true,
        autofocus: false,
      ),
//  Untuk Tombol
      Padding(
        padding: EdgeInsets.only(top: 16.0),
      ),
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          child: FlatButton(
            child: Text(
              'Registrasi',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              registrasi();
            },
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
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
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/LoginPage");
        },
      )
    ],
  );
}
