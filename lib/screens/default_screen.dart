import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sjyblairgarden/controllers/background_controller.dart';
import 'package:sjyblairgarden/controllers/desktopmenu_controller.dart';
import 'package:sjyblairgarden/main.dart';
import 'package:sjyblairgarden/routes/amstwall_route.dart';
import 'package:sjyblairgarden/routes/elibrary_route.dart';
import 'package:sjyblairgarden/routes/home_route.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class DefaultWebScreen extends StatelessWidget {
  const DefaultWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VariableChangeIdentifier(),
      child: const _DesktopWebScreen(),
    );
  }
}

class _DesktopWebScreen extends StatefulWidget {
  const _DesktopWebScreen();
  @override
  State<_DesktopWebScreen> createState() => DesktopWebScreenActivity();
}

class DesktopWebScreenActivity extends State<_DesktopWebScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VariableChangeIdentifier variableChangeIdentifier =
        Provider.of<VariableChangeIdentifier>(context);
    variableChangeIdentifier.addListener(_onPageChange);
    return buildShortcut(variableChangeIdentifier);
  }

  Widget buildShortcut(VariableChangeIdentifier variableChangeIdentifier) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: variableChangeIdentifier.myPage == 0
                ? const [
                    Color.fromARGB(100, 40, 55, 110),
                    Color.fromARGB(100, 148, 48, 110),
                  ]
                : const [
                    Color.fromARGB(100, 255, 169, 249),
                    Color.fromARGB(99, 121, 68, 66),
                  ],
          ))),
          const BackgroundController(),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                  child:
                      routeChangeIdentifier(variableChangeIdentifier.myPage))),
          IgnorePointer(
              ignoring: true,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Color.fromARGB(160, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0),
                ],
              )))),
          DesktopmenuController(pageChange: variableChangeIdentifier),
        ],
      ),
    );
  }

  Widget routeChangeIdentifier(int pageNumber) {
    switch (pageNumber) {
      case 1:
        return const AmstWallRoute();
      case 2:
        return const ElibraryRoute();
      case 3:
        return const HomeRoute();
      default:
        return const HomeRoute();
    }
  }

  @override
  void dispose() {
    final VariableChangeIdentifier variableChangeIdentifier =
        Provider.of<VariableChangeIdentifier>(context);
    variableChangeIdentifier.addListener(_onPageChange);
    variableChangeIdentifier.removeListener(_onPageChange);
    super.dispose();
  }

  void _onPageChange() {}
}
