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
