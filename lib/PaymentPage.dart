// import 'package:flutter/material.dart';
//
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
//
//
// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print('payment sucessfull');
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     print('payment sucessfull');
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print('payment sucessfull');
//   }
//
//   void _startPayment() {
//     var options = {
//       'key': '[YOUR_RAZORPAY_KEY]',
//       'amount': 10000, // amount in the smallest currency unit (e.g., 100 rupees = 10000)
//       'name': 'Sample Store',
//       'description': 'Payment for your purchase',
//       'prefill': {'contact': '1234567890', 'email': 'example@example.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     _razorpay.open(options);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _startPayment,
//           child: Text('Pay Now'),
//         ),
//       ),
//     );
//   }
// }
