import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/home.dart';
import 'package:news/api/authentication_api.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;
  bool loginError = false;

  TextEditingController userNameController;

  TextEditingController passwordController;

  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOG IN"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: (isLoading) ? _drawLoading() : _drawLogInForm(),
      ),
    );
  }

  Widget _drawLogInForm() {
    if (loginError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "login error",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  loginError = false;
                  isLoading = false;
                });
              },
              child: Text("Try Again"),
            )
          ],
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: userNameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: "User Name"),
            validator: (value) {
              if (value.isEmpty) {
                return "enter your email";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 40),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "enter your email";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 48),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  // TODO: handel  The method 'validate' was called on null error when using(( _formKey.currentState.validate();))
                  if( _formKey.currentState.validate()){
                  setState(() {
                    isLoading = true;
                  });
                  var response = await authenticationAPI.logIn(
                      userNameController.text, passwordController.text);
                  if (response) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  } else {
                    setState(() {
                      loginError = true;
                    });
                  }
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Text("LOG IN"),
              ))
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
