import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ImageGameScreen extends StatefulWidget {
  const ImageGameScreen({super.key});

  @override
  _ImageGameScreenState createState() => _ImageGameScreenState();
}

class _ImageGameScreenState extends State<ImageGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Similarity Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await detectFaceSimilarity();
          },
          child: Text('Detect Face Similarity'),
        ),
      ),
    );
  }

  Future<void> detectFaceSimilarity() async {
    // Endpoint URL
    String url = "https://api.luxand.cloud/photo/similarity";

    // Request headers
    Map<String, String> headers = {
      "token": "6fd21c6151da49e984c378d2ac811062",
    };

    // Prepare form data
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    // Load assets from 'assets' folder
    ByteData byteData1 = await rootBundle.load('asset/sample_1.png');
    ByteData byteData2 = await rootBundle.load('asset/sample_2.png');

    // Convert ByteData to List<int>
    List<int> byteList1 = byteData1.buffer.asUint8List();
    List<int> byteList2 = byteData2.buffer.asUint8List();

    // Add files to the request
    request.files.add(http.MultipartFile.fromBytes('face1', byteList1, filename: 'sample_1.png'));
    request.files.add(http.MultipartFile.fromBytes('face2', byteList2, filename: 'sample_2.png'));
    request.fields['threshold'] = '0.8';

    // Send the request
    var streamedResponse = await request.send();

    // Process the response
    var response = await http.Response.fromStream(streamedResponse);

    // Print the response body
    print(response.body);
  }
}

