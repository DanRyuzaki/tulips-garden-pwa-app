import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:sjyblairgarden/controllers/dynamicsize_controller.dart';
import 'package:sjyblairgarden/controllers/tulipquote_controller.dart';
import 'package:sjyblairgarden/main.dart';
import 'package:sjyblairgarden/packages/gemini_ai_api.dart';
import 'package:sjyblairgarden/statics/others/widgets.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => HomeRouteActivity();
}

class HomeRouteActivity extends State<HomeRoute> {
  GeminiAIApiPackage geminiAIApiPackage = GeminiAIApiPackage();
  String? tulipQuotesController;
  @override
  void initState() {
    tulipQuotesController = TulipQuotesController.getTulipQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VariableChangeIdentifier variableChangeIdentifier =
        Provider.of<VariableChangeIdentifier>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextAnimator(
            "Tulips Garden",
            atRestEffect: WidgetRestingEffects.wave(),
            style: TextStyle(
                color: Colors.white,
                fontSize: DynamicSizeController.calculateAspectRatioSize(
                    context, 0.0856),
                fontFamily: 'PonyClub'),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: FractionallySizedBox(
                widthFactor: 0.5,
                child: SelectableText(
                  tulipQuotesController ?? TulipQuotesController.quotes[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: DynamicSizeController.calculateAspectRatioSize(
                        context, 0.018),
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
          OutlinedButton(
            onPressed: () {
              variableChangeIdentifier.pickATulipLoadingChangeCondition(true);
              TextEditingController inputController = TextEditingController();
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFFD9BEF1),
                          content: Widgets.pickATulipWidget(
                              variableChangeIdentifier, inputController))
                      .animate()
                      .scale(duration: 300.ms)
                      .shimmer(delay: 300.ms, duration: 1000.ms));
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 2.9),
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 21.0, bottom: 21.0),
            ),
            child: Text(
              "PICK A TULIP!",
              style: TextStyle(
                color: Colors.white,
                fontSize: DynamicSizeController.calculateAspectRatioSize(
                    context, 0.014),
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
