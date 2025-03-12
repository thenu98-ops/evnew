



import 'package:ev/pages/charging_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
Map<String, dynamic> paymentObject = {
  "sandbox": true,
  "merchant_id": "1229455",
  "merchant_secret": "MzA1MDc1OTY4NzYzNjM4MzM1ODQxMjk2NTkwNTM1MTIzNTc3ODA=",
  "notify_url": "http://sample.com/notify",
  "order_id": "ItemNo12345",
  "items": "Hello from Flutter!",
  "amount": "500.00",
  "currency": "LKR",
  "first_name": "",
  "last_name": "",
  "email": "",
  "phone": "",
  "address": "",
  "city": "",
  "country": "Sri Lanka",
  "delivery_address": "No. 46, Galle road, Kalutara South",
  "delivery_city": "Kalutara",
  "delivery_country": "Sri Lanka",
};

// Fetch user details from Firebase and update paymentObject
Future<void> updatePaymentObject() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  String userId = user.uid;
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('profile').doc(userId).get();

  if (userDoc.exists) {
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    paymentObject["first_name"] = userData['firstName'] ?? '';
    paymentObject["last_name"] = userData['lastName'] ?? '';
    paymentObject["email"] = userData['email'] ?? '';
    paymentObject["phone"] = userData['phone'] ?? '';
    paymentObject["address"] = userData['address'] ?? '';
    paymentObject["city"] = userData['city'] ?? '';

    
  }
}

// Start payment and update balance after successful payment
// void startPayment(BuildContext context, double amount) async {
//   await updatePaymentObject(); // Update paymentObject with user details

//   paymentObject["amount"] = amount.toStringAsFixed(2);

//   print("Starting Payment with Object: $paymentObject");

//   PayHere.startPayment(
//     paymentObject,
//     (paymentId) async {
//       print("Payment Success. Payment Id: $paymentId");
//       await updateBalance(amount);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Payment Successful!"), backgroundColor: Colors.green),
//       );
//     },
//     (error) {
//       print("Payment Failed. Error: $error");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Payment Failed!"), backgroundColor: Colors.red),
//       );
//     },
//     () {
//       print("Payment Dismissed");
//     },
//   );
// }

void startPayment(BuildContext context, double amount) async {
  await updatePaymentObject();

  paymentObject["amount"] = amount.toStringAsFixed(2);
  print("Starting Payment with Object: $paymentObject");

  PayHere.startPayment(
    paymentObject,
    (paymentId) async {
      print("Payment Success. Payment Id: $paymentId");
      await updateBalance(amount);

      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text("Payment Successful!"), backgroundColor: Colors.green),
      );
    },
    (error) {
      print("Payment Failed. Error: $error");

      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text("Payment Failed!"), backgroundColor: Colors.red),
      );
    },
    () {
      print("Payment Dismissed");
    },
  );
}


// Add paid amount to previous balance in Firebase
Future<void> updateBalance(double amount) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("❌ No user found!"); 
    return;
  }

  String userId = user.uid;
  DocumentReference userRef = FirebaseFirestore.instance.collection('profile').doc(userId);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot userDoc = await transaction.get(userRef);

    if (!userDoc.exists) {
      print("❌ User document does not exist!"); 
      return;
    }

    // Fetch previous balance as double
    double previousBalance = (userDoc.data() as Map<String, dynamic>)["balance"]?.toDouble() ?? 0.0;
    double newBalance = previousBalance + amount;

    print("✅ Previous Balance: $previousBalance, Adding: $amount, New Balance: $newBalance"); 

    transaction.update(userRef, {"balance": newBalance});
    print("✅ Balance updated successfully!");
  }).catchError((error) {
    print("❌ Error updating balance: $error");
  });
}



// Dialog to enter payment amount
void onRechargeTap(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  String userId = user.uid;
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('profile').doc(userId).get();

  if (userDoc.exists) {
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    bool isCharging = userData['isCharging'] ?? false;

    if (isCharging) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stop Charging before topping up your wallet."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
  }

  TextEditingController amountController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AlertDialog(
          title: Text("Enter Amount"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String amountText = amountController.text;
                double? amount = double.tryParse(amountText);

                if (amount == null || amount < 100) {
                  Future.delayed(Duration(milliseconds: 100), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter a valid amount (minimum 100)"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                } else {
                  Navigator.pop(context); // Close the dialog first
                  Future.delayed(Duration(milliseconds: 100), () {
                    startPayment(context, amount);
                  });
                }
              },
              child: Text("Confirm"),
            ),
          ],
        ),
      );
    },
  );
}

