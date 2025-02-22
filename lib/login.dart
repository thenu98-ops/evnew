// import 'register.dart';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'nav.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passwordCon = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 15),
//             Center(
//                 child: Image.asset(
//               'assets/log.png',
//               width: 121,
//               height: 121,
//             )),
//             SizedBox(
//               width: 200,
//               height: 67,
//               child: Align(
//                 alignment: Alignment.centerLeft, // Aligns the text to the left
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Color(0xFF202D51),
//                     fontSize: 40,
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w700,
//                     height: 0,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),


//             // TextField(
//             //   controller: emailCon,
//             //   decoration: const InputDecoration(
//             //     hintText: 'Email',
//             //     border: OutlineInputBorder(),
//             //   ),
//             // ),


//            TextField(
//   controller: emailCon,
//   decoration: InputDecoration(
//     hintText: 'Email',
//     filled: true,  // Fill background color
//     fillColor: Colors.grey[200],  // Gray color fill
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15.0), 
//       borderSide: BorderSide.none // Corner radius
//     ),
//   ),
// ),

//             SizedBox(height: 20),



//  TextField(
//   controller: passwordCon,
//   decoration: InputDecoration(
//     hintText: 'Password',
//     filled: true,  // Fill background color
//     fillColor: Colors.grey[200],  // Gray color fill
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15.0), 
//       borderSide: BorderSide.none // Corner radius
//     ),
//   ),
// ),





//             const SizedBox(height: 12),
//             Center(
//               child: ElevatedButton(
                
// onPressed: () {
//   if (emailCon.text.isNotEmpty && passwordCon.text.length > 6) {
  
//     login(context);
//     emailCon.clear();
//                          Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => NavigationPage(), // Replace with your RegisterScreen
//                         ),
//                       );
//   }
 
//    else {
 
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Please enter a valid email and password (at least 7 characters).'),
//         backgroundColor: Colors.red, 
//         duration: Duration(seconds: 3),  
//       ),
//     );
//   }
// },

//                 child: const Text('Login'),
//               ),
//             ),


//             const SizedBox(height: 16),
//             Center(
//               child: Text(
//                 'OR',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 12,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w700,
//                   height: 0,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 5),


//             Center(
//               child: SizedBox(
//                 width: 198,
//                 height: 41,
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'New to this?',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w400,
//                           height: 0,
//                         ),
//                       ),
//                 TextSpan(
//                   text: '  Register',
//                   style: TextStyle(
//                     color: const Color.fromARGB(255, 0, 0, 0), // Make it look clickable
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Register(), // Replace with your RegisterScreen
//                         ),
//                       );
//                     },
//                 ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),


//           ],
//         ),
//       ),
//       appBar: AppBar(
//         clipBehavior: Clip.antiAlias,
//         title: RichText(
//           text: const TextSpan(
//             children: [
//               TextSpan(
//                 text: 'Pro',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold, // Bold only "Firebase"
//                   color: Colors.black, // Color for "Firebase"
//                 ),
//               ),
//               TextSpan(
//                 text: 'Charger',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight:
//                       FontWeight.normal, // Normal weight for "Tutorials"
//                   color: Colors.black, // Color for "Tutorials"
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: Color.fromARGB(255, 221, 229, 236),
//       ),
//     );
//   }

//   // Future<void> login()async{
//   //   final auth = FirebaseAuth.instance;
//   //   auth.signInWithEmailAndPassword(email: emailCon.text, password: passwordCon.text);

//   // }


// //   Future<void> login(BuildContext context) async {
// //   final auth = FirebaseAuth.instance;
  
// //   try {
// //     // Attempt to sign in the user
// //     await auth.signInWithEmailAndPassword(
// //       email: emailCon.text.trim(), 
// //       password: passwordCon.text.trim(),
// //     );

// //     // If successful, show a success message (or navigate to Home Page)
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('Login successful!'),
// //         backgroundColor: Colors.green,
// //         duration: Duration(seconds: 3),
// //       ),
// //     );
// //   } catch (e) {
// //     // Handle specific FirebaseAuth exceptions
// //     if (e is FirebaseAuthException) {
// //       if (e.code == 'user-not-found') {
// //         // User not found error
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Please register first. User does not exist.'),
// //             backgroundColor: Colors.red,
// //             duration: Duration(seconds: 3),
// //           ),
// //         );
// //       } else if (e.code == 'wrong-password') {
// //         // Wrong password error
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Invalid password. Please try again.'),
// //             backgroundColor: Colors.red,
// //             duration: Duration(seconds: 3),
// //           ),
// //         );
// //       } else {
// //         // Generic error
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Error: ${e.message}'),
// //             backgroundColor: Colors.red,
// //             duration: Duration(seconds: 3),
// //           ),
// //         );
// //       }
// //     } else {
// //       // Non-Firebase errors
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('An unknown error occurred.'),
// //           backgroundColor: Colors.red,
// //           duration: Duration(seconds: 3),
// //         ),
// //       );
// //     }
// //   }
// // }

// Future<void> login(BuildContext context) async {
//   final auth = FirebaseAuth.instance;

//   try {
//     // Attempt to sign in the user
//     await auth.signInWithEmailAndPassword(
//       email: emailCon.text.trim(),
//       password: passwordCon.text.trim(),
//     );

//     // Navigate to Home Page
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => NavigationPage()), // Replace `HomeScreen` with your home page class
//     );
//   } catch (e) {
//     // Handle specific FirebaseAuth exceptions
//     if (e is FirebaseAuthException) {
//       if (e.code == 'user-not-found') {
//         // User not found error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please register first. User does not exist.'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 3),
//           ),
//         );
//       } else if (e.code == 'wrong-password') {
//         // Wrong password error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Invalid password. Please try again.'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 3),
//           ),
//         );
//       } else {
//         // Generic error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.message}'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 3),
//           ),
//         );
//       }
//     } else {
//       // Non-Firebase errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An unknown error occurred.'),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 3),
//         ),
//       );
//     }
//   }
// }


// }




import 'register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'nav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Pro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Charger',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 221, 229, 236),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Center(
                child: Image.asset(
                  'assets/log.png',
                  width: 121,
                  height: 121,
                ),
              ),
              SizedBox(
                width: 200,
                height: 67,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF202D51),
                      fontSize: 40,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailCon,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordCon,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (isValidEmail(emailCon.text) && passwordCon.text.length > 6) {
                      await login(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid email and password (at least 7 characters).'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: 198,
                  height: 41,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'New to this?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: '  Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
        email: emailCon.text.trim(),
        password: passwordCon.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found. Please register first.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Invalid password. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unknown error occurred.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}