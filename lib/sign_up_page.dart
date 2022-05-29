import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'package:flutter_auth/authentication_service.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _name = TextEditingController();
final _formkeyme = GlobalKey<FormState>();

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkeyme,
          child: Column(
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signUp(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        context: context,
                      );
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
