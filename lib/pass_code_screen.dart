import 'package:flutter/material.dart';
import 'package:passcode_screen/widget/custom_bottom_sheet.dart';
import 'widget/custom_grid_list.dart';
import 'widget/custom_button.dart';

class PassCodeScreen extends StatefulWidget {
  const PassCodeScreen({super.key});

  @override
  State<PassCodeScreen> createState() => _PassCodeScreenState();
}

class _PassCodeScreenState extends State<PassCodeScreen> {
  String enterPasscode = '';
  int digits = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 28),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person_outline, size: 38),
            ),
            const SizedBox(height: 16),
            const Text('Enter your 4 digits PIN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 28),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    digits,
                    (i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomButton(
                            height: 25,
                            width: 25,
                            text: '',
                            color: i < enterPasscode.length
                                ? Colors.green
                                : Colors.grey.shade300,
                            radius: 100,
                          ),
                        ))),
            const SizedBox(height: 28),
            CustomGridList(
                keyboardSize: const Size(250, 250),
                children: List.generate(11, (i) {
                  if (i == 10) {
                    if (enterPasscode.isEmpty) {
                      return const SizedBox();
                    }
                  }
                  return CustomButton(
                    radius: 65,
                    textSize: 18,
                    height: 100,
                    width: 100,
                    color: Colors.black,
                    onPressed: () => onButtonPress(i),
                    child: buildBtnText(i),
                  );
                })),
            const SizedBox(height: 30),
            CustomButton(
                text: 'CONTINUE',
                color: enterPasscode.length != digits
                    ? Colors.transparent
                    : Colors.indigo,
                onPressed: enterPasscode.length != digits
                    ? null
                    : () async {
                        // simulate api call
                        showLoadingDialog();
                        await Future.delayed(const Duration(milliseconds: 2000))
                            .whenComplete(
                          () => showModalBottomSheet(
                              backgroundColor: Colors.black26.withOpacity(0),
                              context: context,
                              builder: (context) => CustomBottomSheet(
                                  enterPasscode: enterPasscode)),
                        );
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      })
          ],
        ),
      ),
    );
  }

  void showLoadingDialog() => showDialog(
      context: context,
      builder: (ctx) => Container(
          color: Colors.black26.withOpacity(0.3),
          child: const Center(
            child: CircularProgressIndicator(),
          )));

  void onDeletePressed() => setState(() {
        if (enterPasscode.isNotEmpty) {
          enterPasscode = enterPasscode.substring(0, enterPasscode.length - 1);
        }
      });

  void onKeyPadPressed(int i) => setState(() {
        if (enterPasscode.length < digits) {
          enterPasscode += i.toString();
        }
      });

  void onButtonPress(int i) {
    switch (i) {
      case 10:
        onDeletePressed();
        break;
      default:
        onKeyPadPressed(i);
    }
  }

  Widget buildBtnText(int i) {
    switch (i) {
      case 10:
        return const Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
        );
      case 9:
        return const Text(
          '0',
          style: TextStyle(color: Colors.white, fontSize: 23),
        );

      default:
        return Text(
          '${i + 1}',
          style: const TextStyle(color: Colors.white, fontSize: 23),
        );
    }
  }
}
