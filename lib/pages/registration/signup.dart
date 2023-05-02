import 'package:daily_news_digest/widget/policy_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../home_screen.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();

  SignupForm({required this.tabController});

  final TabController? tabController;

}

class _SignupFormState extends State<SignupForm> {

  final color = const Color(0xffFE0000);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool conditions = false;

  CountryCode _selectedCode = CountryCode.fromCode('IN');

  final _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Container(
          height: double.infinity,
          color: Colors.grey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 2, 40, 2),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Create an",
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

                    const Text("Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                          hintText: 'John doe',
                          suffixIcon: Icon(Icons.person, color: color,), // add an icon at the end of the text field
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

                    const Text("Contact no",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        CountryCodePicker(
                          onChanged: (code) {
                            setState(() {
                              _selectedCode = code!;
                            });
                          },
                          initialSelection: 'IN',
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              suffixIcon: Icon(Icons.phone, color: color,),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.black),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.black),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: conditions,
                              activeColor: color,
                              onChanged: (newValue) {
                                // TODO: Handle checkbox value change
                                setState(() {
                                  conditions = !conditions;
                                });
                              },
                            ),
                            const SizedBox(width: 4),
                            const Text("I agree with",
                              style: TextStyle(

                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => showDialog(context: context, builder: (BuildContext context) {
                                return const PolicyDialog();
                              }),
                              child: Text("terms & condition",
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an Account?",
                              style: TextStyle(

                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => widget.tabController!.animateTo(0),
                              child: Text("Sign In",
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

          if( conditions &&
            _nameController.text != '' &&
            _emailController.text.isNotEmpty != '' &&
            _phoneController.text.isNotEmpty != '' &&
            _passwordController.text.isNotEmpty != ''
          ) {
            print(_nameController.text+_emailController.text+_phoneController.text+ _passwordController.text);
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
              );
              // TODO: Navigate to home page or display success message
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          } else {
            print(_nameController.text+_emailController.text+_phoneController.text+ _passwordController.text);
            print('Enter all fields');
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
                  "REGISTER",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                )
            ),
          ),
        ),
      ),
    );



  }
}
