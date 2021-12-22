import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/page/navigation.dart';
import 'package:flutter_application_2/ui/singup.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Loginpage extends StatefulWidget {
  const Loginpage({ Key? key }) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  singin() async {
    try{
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);
      var authCredential =userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>navigation()));
      }
      else{
        Fluttertoast.showToast(msg:"try");
    }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Weak-password') {
        Fluttertoast.showToast(msg: 'the password is worng');
      } else if (e.code == 'email-already-in use') {
        Fluttertoast.showToast(msg: 'account already exist');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            
            Colors.redAccent,
            Colors.amber,
            Colors.blue,
            Colors.red,
            Colors.green
          ])),
          child: Column(
            children: [
              SizedBox(
                height: 130,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Welcome!',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                 border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)), 
                                labelText: 'Enter Email',
                                hintText: 'Enter your Email',
                               prefixIcon: Icon(Icons.mail),
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'Enter Password',
                              hintText: 'password must be 6 character',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: _obscureText == true
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.visibility_off,
                                            size: 20,
                                          )),
                            ),
                          ),
                        ),
                       
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          color: Colors.blue,
                            onPressed: () {
                            singin();
                            },
                            child: Text(
                              '        Login          ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('      Forget  password?'),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              onPressed: (){
                                       Navigator.push(context, CupertinoPageRoute(builder: (context)=> kiholo()));
                            }, child: Text(
                              'Sing Up',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),)
                            
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
    );
  }
}