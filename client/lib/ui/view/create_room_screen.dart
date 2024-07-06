import 'package:client/common/const/app_colors.dart';
import 'package:client/common/widgets/custom_auth_button.dart';
import 'package:client/common/widgets/custom_text.dart';
import 'package:client/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "방 만들기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            CustomTextField(
              controller: _nameController,
              hintText: '닉네임을 입력하세요',
            ),
            SizedBox(height: size.height * 0.045),
            CustomButton(onTap: () {}, text: '시작'),
          ],
        ),
      ),
    );
  }
}
