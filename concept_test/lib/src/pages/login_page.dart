import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3.0,
                            offset: Offset(0.0, 5.0),
                            spreadRadius: 3.0)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Log in', 
                        style: TextStyle(fontSize: 20.0)),
                      _mailAuthentication(),
                      Divider(),
                      SizedBox(height: 10.0,),
                      _googleSignInButton(),
                      _facebookSignInButton(),
                      _twitterSignInButton(),
                    ]
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  _mailAuthentication() {
    return Column(
      children: [
        // email stream builder
        StreamBuilder(
          
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.alternate_email, color: Colors.blue),
                    hintText: 'example@email.com',
                    labelText: 'E-mail',
                    errorText: snapshot.error
                ),
              )
            );
          }
        ), SizedBox(height: 10.0,),
        // pass stream builder
        StreamBuilder(          
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline, color: Colors.blue),
                    labelText: 'Password',
                    errorText: snapshot.error
                ),
              )
            );
          }
        ), SizedBox(height: 10.0,),
        // Submit logit button
        StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Sign In')
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              elevation: 0.0,
              color: Colors.blue,
              textColor: Colors.white,
              onPressed:()=> Navigator.pushReplacementNamed(context, 'location')
            );
          },
        ), SizedBox(height: 10.0,),
      ],
    );

  }

  _googleSignInButton() {
    return SignInButton(
      Buttons.Google,       
      text: "Sign in with Google",
      onPressed: ()=>Navigator.pushReplacementNamed(context, 'locationO')
    );
  }

  _facebookSignInButton() {
    return SignInButton(
      Buttons.Facebook, 
      text: "Sign in with Facebook",
      onPressed: ()=>Navigator.pushReplacementNamed(context, 'location')
    );
  }

  _twitterSignInButton() {
    return SignInButton(
      Buttons.Twitter, 
      text: "Sign in with Twitter",
      onPressed: ()=>Navigator.pushReplacementNamed(context, 'location')
    );
  }
}
