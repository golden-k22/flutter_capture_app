import 'package:flutter/material.dart';
import 'package:photo_pdf/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentPage> {
  final TextEditingController _priceController =
      TextEditingController(text: r'$' + pdfPrice.toStringAsFixed(2));
  final TextEditingController _taxController =
      TextEditingController(text: r'$' + taxRate.toStringAsFixed(2));
  final TextEditingController _pdfCountController =
      TextEditingController(text: '5');
  final TextEditingController _totalPurchaseController =
      TextEditingController();

  Map<String, dynamic>? paymentIntent;

  Future<int> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent("20.00", "USD");

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.light,
          merchantDisplayName: "Your Business Name",
        ),
      );

      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Successful!")),
      );
      return 1;
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Failed")),
      );
      return 0;
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Convert amount to cents
      int amountInCents = (double.parse(amount) * 100).toInt();

      // Use Stripe's test secret key (Replace with your own in production)
      String secretKey = stripeSecretKey;
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "amount": amountInCents.toString(),
          "currency": currency,
          "payment_method_types[]": "card",
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      print("Error creating payment intent: $e");
      throw Exception("Failed to create payment intent");
    }
  }

  @override
  void initState() {
    super.initState();
    _calculateTotalPurchase();
    _priceController.addListener(_calculateTotalPurchase);
    _taxController.addListener(_calculateTotalPurchase);
    _pdfCountController.addListener(_calculateTotalPurchase);
  }

  @override
  void dispose() {
    _priceController.removeListener(_calculateTotalPurchase);
    _taxController.removeListener(_calculateTotalPurchase);
    _pdfCountController.removeListener(_calculateTotalPurchase);
    _priceController.dispose();
    _taxController.dispose();
    _pdfCountController.dispose();
    _totalPurchaseController.dispose();
    super.dispose();
  }

  void _calculateTotalPurchase() {
    final int pdfCount = int.tryParse(_pdfCountController.text) ?? 0;
    final double totalPurchase = (pdfPrice + taxRate) * pdfCount;
    _totalPurchaseController.text = r'$' + totalPurchase.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Payment Screen'),
      // ),

      body: Container(
        margin: EdgeInsets.only(top: appPadding * 2, bottom: appPadding),
        padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image(
                  image: AssetImage('assets/images/pdf.png'),
                  width: 60,
                  height: 60,
                ),
                Text(
                  "PDF SENT FOR\n PROCESSING",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                )
              ]),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, left: 8.0, right: 8.0, bottom: 8.0),
                child: TextField(
                  controller: _priceController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: r'$ / PDF',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _taxController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'TAX',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _pdfCountController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PDF COUNT',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _totalPurchaseController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'TOTAL PURCHASE',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to the previous page
                      },
                      child: Text('CONFIRM'),
                    ),
                    ElevatedButton(
                      onPressed: makePayment,
                      child: Text("Pay"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
