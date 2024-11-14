import 'package:flutter/material.dart';
import 'package:quiz_app/utils/quiz.dart';

class Quizscreen extends StatefulWidget {
  final String name;
  const Quizscreen({required this.name, super.key});

  @override
  State<Quizscreen> createState() => _QuizscreenState();
}

PageController pageController = PageController(initialPage: 0);

class _QuizscreenState extends State<Quizscreen> {
  int correctanswers = 0;
  int? selectedOptionIndex;
  bool? isAnswerCorrect;
  bool isAnswerSelected = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final paddingSize = isSmallScreen ? 10.0 : 15.0;
    final fontSize = isSmallScreen ? 23.0 : 30.0;
    final questionFontSize = isSmallScreen ? 23.0 : 28.0;
    final optionFontSize = isSmallScreen ? 16.0 : 20.0;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: paddingSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hey! ${widget.name}",
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Evaluate your skills with the quiz.",
                      style: TextStyle(fontSize: optionFontSize, color: Colors.grey[200]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: paddingSize),
              child: PageView.builder(
                controller: pageController,
                itemCount: data.length,
                itemBuilder: (context, pageIndex) {
                  final quizdata = data[pageIndex];
                  final correctAnswerIndex = quizdata['answer'];

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: paddingSize),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          quizdata['question'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: questionFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),//
                        ...List.generate(
                          quizdata['options'].length,
                              (optionIndex) {
                            Color borderColor = Colors.black;
                            if (selectedOptionIndex != null) {
                              if (optionIndex == selectedOptionIndex) {
                                borderColor = isAnswerCorrect == true
                                    ? Colors.green
                                    : Colors.red;
                              } else if (optionIndex == correctAnswerIndex) {
                                borderColor = Colors.green;
                              } else {
                                borderColor = Colors.red;
                              }
                            }

                            return GestureDetector(
                              onTap: isAnswerSelected
                                  ? null
                                  : () {
                                setState(() {
                                  selectedOptionIndex = optionIndex;
                                  isAnswerCorrect =
                                      optionIndex == correctAnswerIndex;

                                  if (isAnswerCorrect == true) {
                                    correctanswers++;
                                  }
                                  isAnswerSelected = true;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderColor, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      quizdata["options"][optionIndex],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: optionFontSize),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Control buttons with responsiveness
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              pageIndex == 0
                                  ? const SizedBox()
                                  : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedOptionIndex = null;
                                    isAnswerCorrect = null;
                                    isAnswerSelected = false;
                                    pageController.previousPage(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text("Back"),
                              ),
                              pageIndex == data.length - 1
                                  ? ElevatedButton(
                                onPressed: () {
                                  showBottomSheet(
                                    enableDrag: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 500,
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: 250,
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                    border: Border.fromBorderSide(
                                                      BorderSide(
                                                        width: 2,
                                                        color: correctanswers < 5
                                                            ? Colors.red
                                                            : Colors.green,
                                                      ),
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  correctanswers < 5
                                                      ? "Oops!\n$correctanswers/10"
                                                      : "Yeah!\n$correctanswers/10",
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  correctanswers = 0;
                                                  pageController.jumpTo(0);
                                                  Navigator.pop(context);
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: const Text(
                                                "Start Again",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text("Submit"),
                              )
                                  : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedOptionIndex = null;
                                    isAnswerCorrect = null;
                                    isAnswerSelected = false;
                                    pageController.nextPage(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text("Next"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
