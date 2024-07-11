import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sjyblairgarden/controllers/firestore_errors_controller.dart';
import 'package:sjyblairgarden/screens/default_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

bool get isMobile =>
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) &&
    kIsWeb == false;

void main() async {
  runApp(const MyApp());
  try {
    Gemini.init(apiKey: 'YOUR_API_KEY');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    FirestoreErrorsController.firestoreErrorsController(
        e.toString(), "Gemini Firestore Init");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tulips Garden",
      initialRoute: '/',
      routes: {
        '/': (context) => Animate(
            effects: [ShimmerEffect(delay: 300.ms, duration: 1500.ms)],
            child: const DefaultWebScreen()),

        /* * * * * * * * * * * * * * * * * * * * * * * * * * * * 
         *                                                     *
         * ryuryuryu.dart                                      *
         * '/AddBook.ryu': (context) => AddBook(),             *
         * '/ErrorLogList.ryu': (context) => ErrorLogList(),   *
         * UI tester                                           *  
         * '/UITest.ryu': (context) => UITester()              *
         *                                                     *
         * * * * * * * * * * * * * * * * * * * * * * * * * * * */
      },
    );
  }
}

class VariableChangeIdentifier extends ChangeNotifier {
  int _myPage = 0;
  int get myPage => _myPage;
  void pageNumberChangeValue(int pageNumber) {
    _myPage = pageNumber;
    notifyListeners();
  }

  String _tulipRecommendationGlobal = '''''', _tulipDescriptionGlobal = '''''';
  String get tulipRecommendationGlobal => _tulipRecommendationGlobal;
  String get tulipDescriptionGlobal => _tulipDescriptionGlobal;
  void pickATulipChangeValue(
      String tulipRecommendation, String tulipDescription) {
    _tulipRecommendationGlobal = tulipRecommendation;
    _tulipDescriptionGlobal = tulipDescription;
    notifyListeners();
  }

  bool _pickATulipLoadingGlobal = true;
  bool get pickATulipLoadingGlobal => _pickATulipLoadingGlobal;
  void pickATulipLoadingChangeCondition(bool condition) {
    _pickATulipLoadingGlobal = condition;
    notifyListeners();
  }
}
