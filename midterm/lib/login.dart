import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              // TODO: Add a beveled rectangular border to CANCEL (103)
              children: <Widget>[
                // TODO: Add buttons (101)
                TextButton(
                  child: Text('CANCEL', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    // TODO: Clear the text fields (101)
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                TextButton(
                  child: Text('Sign Up', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    // TODO: Clear the text fields (101)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                ),
                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                SizedBox(
                  width: 100.0,
                  child: ElevatedButton(
                      child: Text('NEXT'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class SignupPage extends StatelessWidget {
  final _username = GlobalKey<FormState>();
  final _password = GlobalKey<FormState>();
  final _confirm = GlobalKey<FormState>();
  final _email = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
            SizedBox(height: 80.0),
            Form(
              key: _username,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Form(
              key: _password,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
              SizedBox(height: 12.0),
              Form(
                key: _confirm,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Confirm Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 12.0),
              Form(
                key: _email,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Email Address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Email Address',
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  SizedBox(
                    width: 100.0,
                    child: ElevatedButton(
                      child: Text('SIGN UP'),
                      onPressed: () {
                        var _valid1 = _username.currentState.validate();
                        var _valid2 = _password.currentState.validate();
                        var _valid3 = _confirm.currentState.validate();
                        var _valid4 = _email.currentState.validate();
                        if(_valid1 && _valid2 && _valid3 && _valid4)
                          Navigator.pop(context);
                      }
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

