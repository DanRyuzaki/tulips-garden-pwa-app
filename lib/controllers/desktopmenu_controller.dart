import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sjyblairgarden/main.dart';
import 'package:sjyblairgarden/statics/others/widgets.dart';

class DesktopmenuController extends StatelessWidget {
  final VariableChangeIdentifier _variableChangeIdentifier;

  const DesktopmenuController(
      {super.key, required VariableChangeIdentifier pageChange})
      : _variableChangeIdentifier = pageChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 50, left: 30, top: 20, bottom: 30),
          child: InkWell(
            onTap: () {
              _variableChangeIdentifier.pageNumberChangeValue(0);
            },
            child: const Text(
              "Akira Blair",
              style: TextStyle(
                color: Colors.white,
                fontSize: 31.6,
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: MediaQuery.of(context).size.width <= 860
              ? [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              elevation: 0,
                              child: Widgets.mobileMenuDrawerWidget(
                                  _variableChangeIdentifier),
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: InkWell(
                      onTap: () {
                        _variableChangeIdentifier.pageNumberChangeValue(1);
                      },
                      child: Opacity(
                          opacity:
                              _variableChangeIdentifier.myPage == 1 ? 0.5 : 1,
                          child: const Text(
                            "AMSTERDAM WALL",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.6,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: InkWell(
                      onTap: () {
                        _variableChangeIdentifier.pageNumberChangeValue(2);
                      },
                      child: Opacity(
                          opacity:
                              _variableChangeIdentifier.myPage == 2 ? 0.5 : 1,
                          child: const Text(
                            "E-LIBRARY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.6,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 50, 30),
                    child: InkWell(
                      onTap: () {
                        Widget moreInfoWidget = Widgets.moreInfoWidget();
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              elevation: 0,
                              child: moreInfoWidget,
                            ),
                          ),
                        );
                        _variableChangeIdentifier.pageNumberChangeValue(0);
                      },
                      child: const Text(
                        "MORE INFO",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.6,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
        ),
      ],
    );
  }
}
