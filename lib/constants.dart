import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ActionStage { capture, pdf, process, send }

const double appPadding = 24.0;

const Color white = Colors.white;
const Color primaryColor = Color.fromRGBO(121, 77, 141, 1.0);
const Color yellowColor = Color.fromRGBO(255, 206, 101, 1.0);
const Color actionColor = Color.fromARGB(255, 19, 171, 182);
const Color actionColorLight = Color.fromARGB(220, 19, 171, 182);

const double pdfPrice = 1.0;
const double taxRate = 0.05;

void showSuccessMsg(msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: actionColorLight,
    textColor: Colors.white,
    fontSize: 16.0);

void showErrorMsg(msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white,
    fontSize: 16.0);

OutlinedButton actionButton(
    {required String text, required VoidCallback action}) {
  final ButtonStyle raisedButtonStyle = OutlinedButton.styleFrom(
    side: BorderSide(color: actionColor, width: 2),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );

  return OutlinedButton(
      style: raisedButtonStyle,
      onPressed: action,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: actionColor,
          height: 1.3,
        ),
        textAlign: TextAlign.center,
      ));
}

const String stripePublishableKey =
    "pk_test_51QwBm3BtkHGSSHAPPMTHlhuWJnnIvKijGh6DanCVzl5dqT7eH29tLfhvhBz9EvRn0MmVTyBZCa4IoEuvpg7LIrNI00UEHyh61A";
const String stripeSecretKey =
    "sk_test_51QwBm3BtkHGSSHAPHLItWWxeuFtGNJyRdNqwVyrH046coNMScH79hrp2um2FK0QYS8yCXTmArRlIdLaD1GPUKlKd00dSCcNaPJ";
const String dropboxAccessToken =
    "sl.u.AFkKZzwQg_vzHr2OexPabB9yWiWaOIxYobycdHJfsdkrOw7lvwBRF8m9zzc1Bi37XNx1K27SoKn6yhuJFuIbd-V4Hmyga5p_5imwSv7iCtuXZkPhywh2sx7frII4R6hX2MhRUMA9Ly-Ny-RAn-ot3DJTYIU6ZDzuAiuMhxfeCDluZnrI7b6QW3ZfojAyYt8nDjfMV2KH73ILN4e7HjpcKcY6PzgREN6OAyQ6AO-YuOFC5eMOy_Fi2UwkLnGHCA1eIZ-dMacbUjFC3llKfgxbI2Bml-5jmKqiN6I1n096W0yITpV877HquCe5LDhMH4ovyv3aM2s-tBTyO2HJZDtXNbI9Cln5k0zSOiOlJwOnQ2_lLvezxk1ziBKCiqjuudju1fDiSB-iOoTKpJtGFMM3GJPfDzrVyyAW7WvScVyl2AR_QJMTmOhTKk8lOos0y1zaKTLbzSEj_q7OOeInLVGxjbaZOMDAgy3H6krQg5KcTic8lbuzJ6hqHWxC6OXnANIWZb1B2B4wFs3L_DyjW2LYp8J0o_oTWryk7G7U66knGQeWt2_eSW1SMY4utbAqW0liCHeivMZuPb0y-MMtrsYmv7wMMofc9IZgekAo-h58HH2s1auXKcPRk2iWdRqK7IPiPRcR_X98saxHzMrjzbIrKUTkTlAWTwiiGeGDe_ZPlYArKHwfH4mOTEFk4DnuKs7T07yO0fAWQJQ3U34bIQdtSTd8cPbWqoSmxDNhbgkMFbuR6t321XAgvUdwHOlAlCSHft6u6TXvThXrLWPgLD72bIrhCyv70gcM9iAhDQIpHFsmCWdP99Jq1ygFZq-G3NSAbrDcC8GVenT3iYuRqzLFKiZjGUCTEhXr916ozdLvC8daLzOsbhjT5hqJ3r-0JpCkHNNwOFuTWF3VB2eFV0TLVu0eVXdHDrY1bZNlKi3Ojh56cDGf5bqJjJwjGEyzEkML5PDmEPDpXk6AO1JI6q-Q-tCcca2MfbvlfOeqxKAEeYDVQOX4vWcC5OXbJBACeOmbXhn8wsjsttSI8WH4rtiLVDSzILwpMCdrXdvKddscyanDfq2jyXzZgT4rvfH0Tm9E6jnXvCFCzSaqfJYhi8_tGf42M8jevVHQxuIFrT-tt-cwSiybWeMw8xuKxhOIuEV0wy86RBFjjRgoyDBomez225CaUgIjeutrL-Br_kKEu5H7qTb5wt0WtHfi38RGj4d8x4Jrgz1Q3Sb89yPE-w2FfhAQ5ozJr1kwaDvtf14wqZMTsXZtPnvYL_lsx8aQklM5-MCIMw5sgHaWboxevXQKcrI2XGcG0zRtqwllQdSc7ARjITFR79punvxD9SSsEJ-QDu4sODjGX8RkXyRwbTMsd7nzmqu_FQ7c6sCM0Vp_H_Ex0dryKdpy9fZ2Q0kw0WblBGyv7bSA0z30uHlEVwYgYgS4";
