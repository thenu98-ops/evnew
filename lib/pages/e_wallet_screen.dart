// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../services/payhere_service.dart';
// import '../services/firebasemodel.dart';
// import 'package:firebase_auth/firebase_auth.dart';






// User? user = FirebaseAuth.instance.currentUser;



// class EWalletScreen extends StatefulWidget {
//   const EWalletScreen({super.key});

//   @override
//   State<EWalletScreen> createState() => _EWalletScreenState();

  
// }

// class _EWalletScreenState extends State<EWalletScreen> {
//   String nama = "";
//   String gana= "0.00";
//   @override
//     void initState() {
//     super.initState();
//     _fetchUserName();
//     _fetchBalance();
//   }


//     void _fetchBalance() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentSnapshot profileDoc = await FirebaseFirestore.instance
//           .collection('profile')
//           .doc(user.uid)
//           .get();

//       if (profileDoc.exists) {
//         setState(() {
//           gana = profileDoc['balance'].toString(); // Fetch balance
//         });
//       }
//     }
//   }


//   void _fetchUserName() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('profile').doc(user.uid).get();
//       setState(() {
//         nama = userDoc['firstName'] ?? "User";
//       });
//     }
//   }

//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('E-Wallet'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(height: BorderSide.strokeAlignCenter),
//                         // Display Hello + First Name
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(text: 'Hello ', style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
//                   TextSpan(text: nama+''+'!', style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),


            
//             Center(
//               child: Image.asset('assets/ewallet.png', width: 200, height: 200),
//             ),
//             Center(
//               child: SizedBox(
//                 width: 300,
//                 height: 38,
//                 child: Text(
//                   'Your Balance',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: Container(
//                 width: 350,
//                 height: 150,
//                 decoration: ShapeDecoration(
//                   color: Color(0x3DAEEDE6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(37),
//                   ),
//                 ),

//         child: Center(
//     child: Text(
//         "LKR $gana", // Display the updated balance
//         style: const TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//   ),

//               ),
//             ),
//             SizedBox(height: 20),

//             // Buttons Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Recharge Button
//                   InkWell(
//                     onTap: () {
//                       print('Recharge Button Pressed');



//                 onRechargeTap(context);





//                     },
//                     child: Container(
//                       width: 121,
//                       height: 43,
//                       decoration: ShapeDecoration(
//                         color: Color(0x7000A1E4),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Recharge',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Transaction Button
//                   InkWell(
//                     onTap: () {
//                       print('Transaction Button Pressed');
//                     },
//                     child: Container(
//                       width: 121,
//                       height: 43,
//                       decoration: ShapeDecoration(
//                         color: Color(0x7702F0A4),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Transaction',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Container (End of Buttons Section)
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/payhere_service.dart';

class EWalletScreen extends StatefulWidget {
  const EWalletScreen({super.key});

  @override
  State<EWalletScreen> createState() => _EWalletScreenState();
}

class _EWalletScreenState extends State<EWalletScreen> {
  late Future<Map<String, String>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
  }

  Future<Map<String, String>> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('profile').doc(user.uid).get();

      if (userDoc.exists) {
        return {
          "name": userDoc['firstName'] ?? "User",
          "balance": userDoc['balance'].toString() ?? "0.00"
        };
      }
    }
    return {"name": "User", "balance": "0.00"};
  }

  Future<void> _refreshData() async {
    setState(() {
      _userDataFuture = _fetchUserData(); // Re-fetch data when pulled down
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('E-Wallet'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<Map<String, String>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            String nama = snapshot.data!['name']!;
            String gana = snapshot.data!['balance']!;

            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Hello ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '$nama!',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Image.asset('assets/ewallet.png', width: 200, height: 200),
                ),
                Text(
                  'Your Balance',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 350,
                    height: 150,
                    decoration: ShapeDecoration(
                      color: Color(0x3DAEEDE6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "LKR $gana",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => onRechargeTap(context),
                        child: Container(
                          width: 121,
                          height: 43,
                          decoration: ShapeDecoration(
                            color: Color(0x7000A1E4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Recharge',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('Transaction Button Pressed');
                        },
                        child: Container(
                          width: 121,
                          height: 43,
                          decoration: ShapeDecoration(
                            color: Color(0x7702F0A4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Transaction',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
