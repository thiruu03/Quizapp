import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quizscreen.dart';

class Introscreen extends StatelessWidget {
  const Introscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final paddingSize = isSmallScreen ? 20.0 : 40.0;
    final fontSize = isSmallScreen ? 28.0 : 36.0;
    final buttonFontSize = isSmallScreen ? 20.0 : 24.0; //

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter Quiz App',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Quizscreen(name: textEditingController.text),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please Enter Your Name")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
