import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_screen.dart';

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();

  SigninForm({required this.tabController});

  final TabController? tabController;
}

class _SigninFormState extends State<SigninForm> {

  final color = const Color(0xffFE0000);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Container(
          height: double.infinity,
          color: Colors.grey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 2, 40, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SignIn into your",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: color
                          ),
                        ),
                        Text("Account",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: color
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 14,),

                    const Text("Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        hintText: 'johndoe@gmail.com',
                        suffixIcon: Icon(Icons.email, color: color,), // add an icon at the end of the text field
                        contentPadding: const EdgeInsets.only(top: 18.0),// reduce the vertical spacing
                        isDense: true, // reduce the overall height of the text field
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),)
                      ),

                    ),

                    const SizedBox(height: 10,),

                    const Text("Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: Icon(Icons.lock, color: color,), // add an icon at the end of the text field
                        contentPadding: const EdgeInsets.only(top: 18.0), // reduce the vertical spacing
                        isDense: true, // reduce the overall height of the text field
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),)
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text("Forgot Password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Text("Login with",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                try {
                                  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                                  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

                                  final AuthCredential credential = GoogleAuthProvider.credential(
                                    accessToken: googleAuth.accessToken,
                                    idToken: googleAuth.idToken,
                                  );

                                  await FirebaseAuth.instance.signInWithCredential(credential);
                                  // TODO: Navigate to home page or display success message
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  print(e.message);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/search.png',
                                  height: 24.0,
                                  width: 24.0,
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            GestureDetector(
                              onTap: () async {
                                // Initialize Facebook Login
                                final LoginResult result = await FacebookAuth.instance.login();

                                // Check if the user has granted the required permissions
                                if (result.status != LoginStatus.success) {
                                  print('Facebook login failed.');
                                  return null;
                                }

                                // Create a Facebook credential
                                final OAuthCredential facebookCredential =
                                FacebookAuthProvider.credential(result.accessToken!.token);

                                // Sign up with the Facebook credential
                                try {
                                  final userCredential =
                                  await FirebaseAuth.instance.signInWithCredential(facebookCredential);

                                } on FirebaseAuthException catch (e) {
                                  print(e.message);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/facebook.png',
                                  height: 24.0,
                                  width: 24.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an Account?",
                              style: TextStyle(
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => widget.tabController!.animateTo(1),
                              child: Text("Register Now",
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  // TODO: Navigate to home page or display success message
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                } catch (e) {
                  print(e);
                }
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child:  const SizedBox(height: 60,
            child: Center(
                child:
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                )

            ),
          ),
        ),
      ),
    );
   }
}
