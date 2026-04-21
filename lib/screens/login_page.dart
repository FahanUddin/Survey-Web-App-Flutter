import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:surveywebapp/main.dart';
import 'package:surveywebapp/models/user.dart';
import 'package:surveywebapp/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surveywebapp/screens/surveypage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  //final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  //final splash = Get.put(const Splash());

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool _isEditingEmail = true;
  bool _isEditingPassword = true;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0.0,
    );
    //email field

    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) =>
            _isEditingEmail ? _validateEmail(emailController.text) : null,
        /* validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },*/
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),

          prefixIcon: Icon(
            Icons.mail,
            color: const Color(0xFF17262A),
          ),
          //contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) => _isEditingPassword
            ? _validatePassword(passwordController.text)
            : null,
        /*validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },*/
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: const Icon(
            Icons.vpn_key,
            color: Color(0xFF17262A),
          ),
          //contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xff45a29e),
      child: MaterialButton(
          height: 30,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          minWidth: MediaQuery.of(context).size.width / 1.35,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    Container headerSection() {
      return Container(
        child: const Text("LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff66fcf1),
              fontWeight: FontWeight.bold,
              fontSize: 55,
            )),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xff1f2833),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1f2833),
      ),
      body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: width, //here
              color: const Color(0xff1f2833),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: (width / 7)),
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                            //height: 200,
                            ),
                        headerSection(),
                        SizedBox(height: 45),
                        emailField,
                        SizedBox(height: 25),
                        passwordField,
                        SizedBox(height: 35),
                        loginButton,
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Don't have an account? ",
                                  style: TextStyle(color: Colors.grey)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                },
                                child: const Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Color(0xff45a29e),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ), //this
            ),
          )),
    );
  }

  String? _validateEmail(String value) {
    value = value.trim();

    if (emailController.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value
          .contains(RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String? _validatePassword(String value) {
    value = value.trim();

    if (passwordController.text != null) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      } else if (!value.contains(RegExp(r'^.{6,}$'))) {
        return 'Enter a correct password';
      }
    }

    return null;
  }

  //login method
  Future<String?> signIn(String email, String password) async {
    await Firebase.initializeApp();

    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;
    UserClass userClass = UserClass();

    if (user != null) {
      // checking if uid or email is null
      assert(user.uid != null);
      assert(user.email != null);

      userClass.uid = user.uid;
      userClass.email = user.email;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PollsDemo()));

      return 'Successfully logged in, User UID: ${user.uid}';
    }
    return null;
  }

  // login function
  /*Future signIn(String email, String password) async {
    print("done");
    await Firebase.initializeApp();
    //if (_formKey.currentState!.validate()) {
    //try {
    //await _auth.signInWithEmailAndPassword(email: email, password: password)
    /*.then((value) => {
                print("error")
                //Fluttertoast.showToast(msg: "Login Successful"),
                /*Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage())),*/
              })*/
    //;
    //}
    /*on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        /*showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Your email address appears to be malformed."),
            content: Text(errorMessage!

                /// <-------------- HERE
                ),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );*/
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }*/
  }*/
}
