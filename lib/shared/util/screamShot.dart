import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:screenshot/screenshot.dart';

takeScreenshotandShare(ScreenshotController screenshotController) async {
  late File? _imageFile;
  _imageFile = null;
  screenshotController
      .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
      .then((File image) async {
    _imageFile = image;
    final directory = (await getApplicationDocumentsDirectory()).path;
    Uint8List pngBytes = _imageFile!.readAsBytesSync();
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
    print("File Saved to Gallery");
    await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
  }).catchError((onError) {
    print(onError);
  });
}
