import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class ImageGameScreen extends StatefulWidget {
  final String title;
  const ImageGameScreen({super.key, required this.title});

  @override
  _ImageGameScreenState createState() => _ImageGameScreenState();
}

class _ImageGameScreenState extends State<ImageGameScreen> {
  List<XFile>? _imageFiles;
  String? _resultText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _pickImages();
              },
              child: const Text('Select Images'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_imageFiles != null && _imageFiles!.length > 1) {
                  await detectFaceSimilarity(_imageFiles!);
                } else {
                  setState(() {
                    _resultText = "Please select at least two images.";
                  });
                }
              },
              child: const Text('Detect Face Similarity'),
            ),
            _resultText != null ? Text(_resultText!) : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    setState(() {
      _imageFiles = images;
    });
  }

  Future<void> detectFaceSimilarity(List<XFile> imageFiles) async {
    String url = "https://api.luxand.cloud/photo/similarity";
    Map<String, String> headers = {
      "token": "6fd21c6151da49e984c378d2ac811062",
    };

    double highestSimilarity = 0.0;
    String bestMatch = "";

    for (int i = 0; i < imageFiles.length; i++) {
      for (int j = i + 1; j < imageFiles.length; j++) {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);

        Uint8List byteData1 = await imageFiles[i].readAsBytes();
        Uint8List byteData2 = await imageFiles[j].readAsBytes();

        request.files.add(http.MultipartFile.fromBytes('photo1', byteData1,
            filename: imageFiles[i].name));
        request.files.add(http.MultipartFile.fromBytes('photo2', byteData2,
            filename: imageFiles[j].name));
        request.fields['threshold'] = '0.8';

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print('API response: $jsonResponse'); // 응답 내용을 출력
          double similarity = jsonResponse['similarity'] ?? 0.0; // null 처리 추가
          if (similarity > highestSimilarity) {
            highestSimilarity = similarity;
            bestMatch =
                "Best match: ${imageFiles[i].name} and ${imageFiles[j].name} with similarity $similarity";
          }
        } else {
          print('Error: ${response.statusCode}');
          print('Response body: ${response.body}'); // 에러 응답 내용 출력
        }
      }
    }

    setState(() {
      _resultText = highestSimilarity > 0
          ? "$bestMatch\n오늘의 러브샷!"
          : "No similar faces detected.";
    });
  }
}
