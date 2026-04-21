import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';
import 'package:surveywebapp/models/user.dart';

class PollsDemo extends StatefulWidget {
  @override
  _PollsDemoState createState() => _PollsDemoState();
}

class _PollsDemoState extends State<PollsDemo> {
  var vote = '50';
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('questions').snapshots();
  double option1 = 1.0;
  double option2 = 1.0;
  double option3 = 1.0;
  double option4 = 1.0;

  String user = "user@gmail.com";
  Map usersWhoVoted = {
    'test@gmail.com': 1,
    'deny@gmail.com': 3,
    'kent@gmail.com': 2,
    'xyz@gmail.com': 3
  };
  String creator = "admin@gmail.com";

  @override
  Widget build(BuildContext context) {
    CollectionReference user =
        FirebaseFirestore.instance.collection('questions');
    var uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: StreamBuilder<QuerySnapshot>(
                    stream: users,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('error');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('loading...');
                      }
                      final data = snapshot.requireData;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 180,
                              width: 280,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                verticalDirection: VerticalDirection.down,
                                children: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        //backgroundColor: Colors.pinkAccent,
                                        primary: Colors.pink,
                                      ),
                                      onPressed: () {
                                        user.doc(uid).update({vote: 'vote'});
                                      },
                                      child: Text(
                                          'User name: ${data.docs[index]['title']}'))
                                ],
                              ));

                          /*Text(
                              'User name: ${data.docs[index]['title']}');*/
                        },
                      );
                    }),
              ),
            )

            /*Polls(
              children: [
                Polls.options(title: 'Java', value: option1),
                Polls.options(title: 'Kotlin', value: option2),
                Polls.options(title: 'Flutter', value: option3),
                Polls.options(title: 'React Native', value: option4),
              ],
              question: Text(
                'Which Andriod App Development technology used?',
                style: TextStyle(fontSize: 17),
              ),
              currentUser: this.user,
              creatorID: this.creator,
              voteData: usersWhoVoted,
              userChoice: usersWhoVoted[this.user],
              onVoteBackgroundColor: Colors.cyan,
              leadingBackgroundColor: Colors.cyan,
              backgroundColor: Colors.white,
              onVote: (choice) {
                print(choice);
                setState(() {
                  this.usersWhoVoted[this.user] = choice;
                });
                if (choice == 1) {
                  setState(() {
                    option1 += 1.0;
                  });
                }
                if (choice == 2) {
                  setState(() {
                    option2 += 1.0;
                  });
                }
                if (choice == 3) {
                  setState(() {
                    option3 += 1.0;
                  });
                }
                if (choice == 4) {
                  setState(() {
                    option4 += 1.0;
                  });
                }
              },
            ),*/
          ],
        ),
      ),
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyPage extends StatefulWidget {
  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Expanded(
            child: Material(
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: _currentStep,
                steps: [
                  getStep(
                      title: 'Choose',
                      child: Text('Vote content'),
                      isActive: true),
                  getStep(
                      title: 'Vote',
                      child: Text('something'),
                      isActive: _currentStep >= 1 ? true : false),
                  getStep(
                      title: 'Submit',
                      child: Text('something'),
                      isActive: _currentStep >= 1 ? true : false),
                ],
                onStepContinue: () {
                  setState(() {
                    _currentStep =
                        (_currentStep + 1) > 1 ? 1 : _currentStep + 1;
                  });
                },
                onStepCancel: () {
                  setState(() {
                    _currentStep =
                        (_currentStep - 1) > 0 ? 0 : _currentStep - 1;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Step getStep(
      {required String title, required Widget child, bool isActive = false}) {
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }
}
*/