import 'package:flutter/material.dart';
import 'package:social_app_ui/components/custom_button.dart';
import 'package:social_app_ui/components/custom_text_field.dart';
import 'package:social_app_ui/screens/main_screen.dart';
import 'package:social_app_ui/util/const.dart';
import 'package:social_app_ui/util/router.dart';
import 'package:social_app_ui/util/validations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app_ui/services/auth.dart';
import 'package:social_app_ui/shared/constants.dart';
import 'package:social_app_ui/shared/loading.dart';



//class Register extends StatefulWidget {
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final String email;
//
//  Register({@required this.email});
//
//  @override
//  _RegisterState createState() => _RegisterState();
//}
//
//class _RegisterState extends State<Register> {
//  bool loading = false;
//  bool validate = false;
//  GlobalKey<FormState> formKey = GlobalKey<FormState>();
//  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//  String email, password, name = '';
//  FocusNode nameFN = FocusNode();
//  FocusNode emailFN = FocusNode();
//  FocusNode passFN = FocusNode();
//
//  register() async {
//    FormState form = formKey.currentState;
//    form.save();
//    if (!form.validate()) {
//      validate = true;
//      setState(() {});
//      showInSnackBar('Please fix the errors in red before submitting.');
//    } else {
//      Router.pushPage(context, MainScreen());
//    }
//  }
//
//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState.removeCurrentSnackBar();
//    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _scaffoldKey,
//      body: Center(
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20.0),
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Hero(
//                tag: 'appname',
//                child: Material(
//                  type: MaterialType.transparency,
//                  child: Text(
//                    '${Constants.appName}',
//                    style: TextStyle(
//                      fontSize: 40.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 100.0,
//              ),
//              Form(
//                autovalidate: validate,
//                key: formKey,
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    CustomTextField(
//                      enabled: !loading,
//                      hintText: "Name",
//                      textInputAction: TextInputAction.next,
//                      validateFunction: Validations.validateName,
//                      onSaved: (String val) {
//                        name = val;
//                      },
//                      focusNode: nameFN,
//                      nextFocusNode: emailFN,
//                    ),
//                    SizedBox(
//                      height: 20.0,
//                    ),
//                    CustomTextField(
//                      enabled: false,
//                      initialValue: widget.email,
//                      hintText: "jideguru@gmail.com",
//                      textInputAction: TextInputAction.next,
//                      validateFunction: Validations.validateEmail,
//                      onSaved: (String val) {
//                        email = val;
//                      },
//                      focusNode: emailFN,
//                      nextFocusNode: passFN,
//                    ),
//                    SizedBox(
//                      height: 20.0,
//                    ),
//                    CustomTextField(
//                      enabled: !loading,
//                      hintText: "Password",
//                      textInputAction: TextInputAction.done,
//                      validateFunction: Validations.validatePassword,
//                      submitAction: register,
//                      obscureText: true,
//                      onSaved: (String val) {
//                        password = val;
//                      },
//                      focusNode: passFN,
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 40.0,
//              ),
//              buildButton(),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  buildButton() {
//    return loading
//        ? Center(child: CircularProgressIndicator())
//        : CustomButton(
//            label: "Register",
//            onPressed: () => register(),
//          );
//  }
//}


class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up                 Study Buddies'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}