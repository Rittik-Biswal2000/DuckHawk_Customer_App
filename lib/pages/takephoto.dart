import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_duckhawk/pages/ageverify.dart';
//import 'utils.dart';

String cstr;
List<CameraDescription> camerasList;

class CameraTest extends StatefulWidget {
  const CameraTest({Key key}) : super(key: key);

  @override
  _CameraTestState createState() => new _CameraTestState();
}

class _CameraTestState extends State<CameraTest> {
  CameraController controller;
  List<String> imageList = <String>[];
  String imagePath;
  double _animatedHeight = 0.0;
  String _errorMsg = '';

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    camerasList = await availableCameras();
    controller = new CameraController(camerasList[1], ResolutionPreset.medium);
    CameraLensDirection cameraLensDirection = camerasList[1].lensDirection;
    print(cameraLensDirection);
    print("drectio");
    print(camerasList);
    await controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    setState(() {
      _animatedHeight = 30.0;
      _errorMsg = message;
    });

    Future<void>.delayed(const Duration(seconds: 1), _hideErrorMsg);
  }

  void _hideErrorMsg() {
    setState(() {
      _animatedHeight = 0.0;
      _errorMsg = '';
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final bool writeAccess = false;
    Directory extDir;
    // if user disagrees to allow storage access the use app storage
    if (writeAccess) {
      extDir = await getExternalStorageDirectory();
    } else {
      extDir = await getApplicationDocumentsDirectory();
    }
    final String dirPath = '${extDir.path}/Pictures/pics';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print('Exception -> $e');
      return null;
    }
    setState(() {
      imageList.add(filePath);
    });
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await controller.initialize();

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await controller.takePicture(path);
            cstr=path.toString();

            // If the picture was taken, display it on a new screen.
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ageverify(path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Text(imagePath),
    );
   }
}
