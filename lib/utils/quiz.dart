class Quiz {
  final int id, answer;
  final String question;
  final List<String> options;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });
}

const List<Map<String, dynamic>> data = [
  {
    "id": 1,
    "question": "1.What is Flutter?",
    "options": ["Framework", "Web tool", "Library", "None of the above"],
    "answer": 0, // Framework
  },
  {
    "id": 2,
    "question": "2.Which programming language is used by Flutter?",
    "options": ["Java", "Kotlin", "Swift", "Dart"],
    "answer": 3, // Dart
  },
  {
    "id": 3,
    "question": "3.What is the purpose of the 'pubspec.yaml' file?",
    "options": [
      "To define dependencies",
      "To configure widgets",
      "To store data",
      "To manage themes"
    ],
    "answer": 0, // To define dependencies
  },
  {
    "id": 4,
    "question": "4.Which widget is used to create a scrollable list?",
    "options": ["Column", "Row", "ListView", "Container"],
    "answer": 2, // ListView
  },
  {
    "id": 5,
    "question": "5.How do you declare a Stateless widget?",
    "options": [
      "By extending StatelessWidget",
      "By extending StatefulWidget",
      "By creating a class",
      "By using a StatefulWidget"
    ],
    "answer": 0, // By extending StatelessWidget
  },
  {
    "id": 6,
    "question": "6.Which command is used to run a Flutter app?",
    "options": ["flutter start", "flutter run", "dart run", "flutter build"],
    "answer": 1, // flutter run
  },
  {
    "id": 7,
    "question": "7.What is the default state management approach in Flutter?",
    "options": ["Provider", "InheritedWidget", "setState", "Redux"],
    "answer": 2, // setState
  },
  {
    "id": 8,
    "question": "8.What does the 'build' method do in Flutter?",
    "options": [
      "Initializes state",
      "Builds the widget tree",
      "Creates animations",
      "Handles user input"
    ],
    "answer": 1, // Builds the widget tree
  },
  {
    "id": 9,
    "question":
        "9.Which Flutter widget is used for aligning children vertically?",
    "options": ["Column", "Row", "Stack", "ListView"],
    "answer": 0, // Column
  },
  {
    "id": 10,
    "question": "10.How do you add a package in a Flutter project?",
    "options": [
      "Edit main.dart",
      "Edit pubspec.yaml",
      "Edit index.html",
      "Edit README.md"
    ],
    "answer": 1, // Edit pubspec.yaml
  },
];
