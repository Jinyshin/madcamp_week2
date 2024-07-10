
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;

// class ImageGameScreen extends StatefulWidget {
//   const ImageGameScreen({super.key, required String title});

//   @override
//   _ImageGameScreenState createState() => _ImageGameScreenState();
// }

// class _ImageGameScreenState extends State<ImageGameScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Face Similarity Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await detectFaceSimilarity();
//           },
//           child: Text('Detect Face Similarity'),
//         ),
//       ),
//     );
//   }

//   Future<void> detectFaceSimilarity() async {
//     // Endpoint URL
//     String url = "https://api.luxand.cloud/photo/similarity";

//     // Request headers
//     Map<String, String> headers = {
//       "token": "6fd21c6151da49e984c378d2ac811062",
//     };

//     // Prepare form data
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.headers.addAll(headers);

//     // Load assets from 'assets' folder
//     ByteData byteData1 = await rootBundle.load('asset/sample_1.jpg');
//     ByteData byteData2 = await rootBundle.load('asset/sample_2.jpg');

//     // Convert ByteData to List<int>
//     List<int> byteList1 = byteData1.buffer.asUint8List();
//     List<int> byteList2 = byteData2.buffer.asUint8List();

//     // Add files to the request
//     request.files.add(http.MultipartFile.fromBytes('face1', byteList1, filename: 'sample_1.jpg'));
//     request.files.add(http.MultipartFile.fromBytes('face2', byteList2, filename: 'sample_2.jpg'));
//     request.fields['threshold'] = '0.8';

//     // Send the request
//     var streamedResponse = await request.send();

//     // Process the response
//     var response = await http.Response.fromStream(streamedResponse);

//     // Print the response body
//     print(response.body);
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageGameScreen extends StatefulWidget {
  const ImageGameScreen({super.key, required this.title});
  final String title;

  @override
  _ImageGameScreenState createState() => _ImageGameScreenState();
}

class _ImageGameScreenState extends State<ImageGameScreen> {
  List<String> imagePaths = [];
  int numberOfPeople = 0;
  List<List<int>> selectedPairs = [];
  List<int> bestPair = [1, 2];
  double highestSimilarity = 0.0; // 유사도 값을 저장하기 위한 변수 추가

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
                await selectNumberOfPeople();
              },
              child: Text('Enter Number of People'),
            ),
            ElevatedButton(
              onPressed: () async {
                await selectImagePairs();
              },
              child: Text('Enter Image Pairs'),
            ),
            ElevatedButton(
              onPressed: () async {
                await detectFaceSimilarity();
              },
              child: Text('Detect Face Similarity'),
            ),
            (bestPair[0] > 0 && bestPair[1] > 0 && bestPair[0] <= imagePaths.length && bestPair[1] <= imagePaths.length)
                ? Column(
                    children: [
                      Image.asset(imagePaths[bestPair[0] - 1]),
                      Image.asset(imagePaths[bestPair[1] - 1]),
                      Text('Similarity: $highestSimilarity'),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> selectNumberOfPeople() async {
    int? numPeople = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberInputDialog();
      },
    );

    if (numPeople != null) {
      setState(() {
        numberOfPeople = numPeople;
        imagePaths = List.generate(numPeople, (index) => 'asset/sample_${index + 1}.jpg');
      });
    }
  }

  Future<void> selectImagePairs() async {
    List<List<int>>? pairs = await showDialog<List<List<int>>>(
      context: context,
      builder: (BuildContext context) {
        return ImagePairsInputDialog(numberOfPeople: numberOfPeople);
      },
    );

    if (pairs != null) {
      setState(() {
        selectedPairs = pairs;
      });
    }
  }

  Future<void> detectFaceSimilarity() async {
    String url = "https://api.luxand.cloud/photo/similarity";
    Map<String, String> headers = {
      "token": "6fd21c6151da49e984c378d2ac811062",
    };

    double highestSimilarity = 0.0;
    List<int> tempBestPair = [0, 1];

    for (List<int> pair in selectedPairs) {
      if (pair[0] <= 0 || pair[0] > imagePaths.length || pair[1] <= 0 || pair[1] > imagePaths.length) {
        print('Invalid pair: ${pair[0]}, ${pair[1]}');
        continue;
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      ByteData byteData1 = await rootBundle.load(imagePaths[pair[0] - 1]);
      ByteData byteData2 = await rootBundle.load(imagePaths[pair[1] - 1]);

      List<int> byteList1 = byteData1.buffer.asUint8List();
      List<int> byteList2 = byteData2.buffer.asUint8List();

      request.files.add(http.MultipartFile.fromBytes('face1', byteList1, filename: 'sample_${pair[0]}.jpg'));
      request.files.add(http.MultipartFile.fromBytes('face2', byteList2, filename: 'sample_${pair[1]}.jpg'));
      request.fields['threshold'] = '0.8';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);

      var jsonResponse = json.decode(response.body);
      double similarity = jsonResponse['similarity'] ?? 0.0;

      if (similarity > highestSimilarity) {
        highestSimilarity = similarity;
        tempBestPair = pair;
      }
    }

    setState(() {
      bestPair = tempBestPair;
      this.highestSimilarity = highestSimilarity; // 유사도 값을 상태로 설정
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Most Similar Faces'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePaths[bestPair[0] - 1]),
              Image.asset(imagePaths[bestPair[1] - 1]),
              Text('Similarity: $highestSimilarity'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class NumberInputDialog extends StatefulWidget {
  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Number of People'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: "Number of People"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(int.tryParse(_controller.text));
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

class ImagePairsInputDialog extends StatefulWidget {
  final int numberOfPeople;
  const ImagePairsInputDialog({required this.numberOfPeople});

  @override
  _ImagePairsInputDialogState createState() => _ImagePairsInputDialogState();
}

class _ImagePairsInputDialogState extends State<ImagePairsInputDialog> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.numberOfPeople, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Image Pairs'),
      content: SingleChildScrollView(
        child: Column(
          children: _controllers.map((controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: "Enter pair (e.g. 1 2)"),
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            List<List<int>> pairs = [];
            for (var controller in _controllers) {
              try {
                List<String> parts = controller.text.split(' ');
                if (parts.length == 2) {
                  int first = int.parse(parts[0]);
                  int second = int.parse(parts[1]);
                  pairs.add([first, second]);
                }
              } catch (e) {
                print('Invalid input format: ${controller.text}');
              }
            }
            Navigator.of(context).pop(pairs);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}