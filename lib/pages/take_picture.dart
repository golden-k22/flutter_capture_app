import 'package:flutter/material.dart';
import 'package:photo_pdf/constants.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'payment.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({super.key});

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  ActionStage stage = ActionStage.capture;
  bool capturing = false;
  bool saving = false;
  bool ready = false;
  XFile? _image;
  File? _pdf;

  Future<void> onStartPressed() async {
    await _initializeControllerFuture;
    setState(() {
      capturing = true;
    });

    XFile image = await _controller!.takePicture();
    setState(() {
      _image = image;
      capturing = false;
    });

    showSuccessMsg("Captured Image successfully");
  }

  Future<void> onSavePressed() async {
    if (_image == null) {
      return showErrorMsg("No image to save");
    }

    if (capturing || saving) {
      return showErrorMsg("Please wait...");
    }

    setState(() {
      _pdf = null;
      saving = true;
    });

    final pdf = pw.Document();
    final directory = await getApplicationDocumentsDirectory();
    final pdfPath = "${directory.path}/captured_image.pdf";

    final imageFile = File(_image!.path);
    final imageBytes = await imageFile.readAsBytes();
    final pdfImage = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(pdfImage));
        },
      ),
    );

    // Save PDF file
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    showSuccessMsg("PDF saved successfully");
    setState(() {
      _pdf = pdfFile;
      saving = false;
    });
  }

  void onNextPressed() {
    setState(() {
      switch (stage) {
        case ActionStage.capture:
          if (_image != null) {
            stage = ActionStage.pdf;
          } else {
            showErrorMsg("Please capture an image first");
          }
          break;

        case ActionStage.pdf:
          if (_pdf != null) {
            stage = ActionStage.process;
          } else {
            showErrorMsg("Please save the image as PDF first");
          }
          break;

        case ActionStage.process:
          stage = ActionStage.send;
          break;

        case ActionStage.send:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage()),
          );
          break;
      }
    });
  }

  void onFinished() {
    setState(() {
      stage = ActionStage.capture;
      _image = null;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _controller?.dispose();
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    }
  }

  Widget cameraView() {
    return _controller == null || capturing
        ? Center(child: CircularProgressIndicator())
        : FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!ready && _image != null) {
                  return documentPreview();
                }

                return CameraPreview(_controller!);
              } else {
                return Center(
                    child: CircularProgressIndicator(color: actionColor));
              }
            },
          );
  }

  Widget documentPreview() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: actionColor, width: 2),
      ),
      child: Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
      ),
    );
  }

  List<OutlinedButton> actionButtons() {
    switch (stage) {
      case ActionStage.capture:
        return [
          actionButton(text: "START", action: onStartPressed),
          actionButton(text: "NEXT", action: onNextPressed),
        ];

      case ActionStage.pdf:
        return [
          actionButton(text: "SAVE", action: onSavePressed),
          actionButton(text: "NEXT", action: onNextPressed),
          actionButton(text: "FINISH", action: onFinished),
        ];

      case ActionStage.process:
        return [
          actionButton(text: "SEND", action: onNextPressed),
          actionButton(text: "FINISH", action: onFinished),
        ];

      case ActionStage.send:
        return [
          actionButton(
              text: "PDF UPLOAD \nFOR PROCESSING", action: onStartPressed),
          actionButton(text: "PAY", action: onNextPressed),
        ];
    }
  }

  Widget contentView() {
    switch (stage) {
      case ActionStage.capture:
        return cameraView();

      case ActionStage.pdf:
        return documentPreview();

      case ActionStage.process:
        return documentPreview();

      case ActionStage.send:
        return Text("Sending...");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(alignment: Alignment.topCenter, children: [
      SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage('assets/images/sign_topbar.png'),
          fit: BoxFit.cover,
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: appPadding * 2, bottom: appPadding),
          padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
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
                    "Take Picture of\n Document Screen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  )
                ]),
                contentView(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: actionButtons())
              ]))
    ]);
  }
}
