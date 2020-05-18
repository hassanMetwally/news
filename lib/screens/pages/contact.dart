import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading =false;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController messageController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: (isLoading)? _drawLoading():_drawForm(),
          ),
        ],
      ),
    );
  }

  Widget _drawForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Your Name"),
            validator: (value) {
              if (value.isEmpty) {
                return "enter your name";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress ,
            decoration: InputDecoration(labelText: "Your Email"),
            validator: (value) {
              if (value.isEmpty) {
                return "enter your email";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: messageController,
            decoration: InputDecoration(labelText: "Your Message"),
            maxLines: 5,
            validator: (value) {
              if (value.isEmpty) {
                return "enter your message";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                    setState(() {
                      isLoading = true;
                    });
                }else{
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Text("SEND"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
