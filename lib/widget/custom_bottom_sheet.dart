import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomBottomSheet extends StatelessWidget {
  final String enterPasscode;
  const CustomBottomSheet({super.key, required this.enterPasscode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '😉😉😉',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                const SizedBox(height: 25),
                Text(
                  enterPasscode,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 150),
                CustomButton(
                  color: Colors.black,
                  text: 'Continue',
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
