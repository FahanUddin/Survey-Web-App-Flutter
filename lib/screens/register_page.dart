import 'package:surveywebapp/screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:surveywebapp/main.dart';
import 'package:surveywebapp/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final FullNameEditingController = new TextEditingController();
  final HomeAddressEditingController = new TextEditingController();
  final SNIEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //first name field
    final FullNameField = TextFormField(
        autofocus: false,
        controller: FullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Full Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          FullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon:
              Icon(Icons.account_circle, color: const Color(0xff66fcf1)),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    //second name field
    final HomeAddressField = TextFormField(
        autofocus: false,
        controller: HomeAddressEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          HomeAddressEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon:
              Icon(Icons.account_circle, color: const Color(0xff66fcf1)),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    final SNIField = TextFormField(
        autofocus: false,
        controller: SNIEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your SNI Number");
          }
          // reg expression for email validation
          if (!RegExp("[0-9]{8}").hasMatch(value)) {
            return ("Please Enter a valid SNI number");
          }
          return null;
        },
        onSaved: (value) {
          SNIEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon:
              Icon(Icons.account_circle, color: const Color(0xff66fcf1)),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: "SNI Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          FullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: Icon(Icons.mail, color: const Color(0xff66fcf1)),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          FullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: const Color(0xff66fcf1),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff45a29e), width: 3.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Color(0xff66fcf1),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xff45a29e),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: const Color(0xff1f2833),
      appBar: AppBar(
        backgroundColor: const Color(0xff1f2833),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff66fcf1)),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xff1f2833),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: (width / 4)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    headerSection(),
                    SizedBox(height: 45),
                    FullNameField,
                    SizedBox(height: 20),
                    HomeAddressField,
                    SizedBox(height: 20),
                    SNIField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      child: const Text("Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff66fcf1),
            fontWeight: FontWeight.bold,
            fontSize: 55,
          )),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
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
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserClass userClass = UserClass();

    // writing all the values
    userClass.email = user!.email;
    userClass.uid = user.uid;
    userClass.FullName = FullNameEditingController.text;
    userClass.HomeAddress = HomeAddressEditingController.text;
    userClass.SNI = SNIEditingController.text;
    userClass.hasVoted = false;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userClass.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
