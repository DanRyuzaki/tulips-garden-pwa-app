import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sjyblairgarden/controllers/dynamicsize_controller.dart';
import 'package:sjyblairgarden/controllers/pickatulip_controller.dart';
import 'package:sjyblairgarden/main.dart';
import 'package:sjyblairgarden/packages/gemini_ai_api.dart';
import 'package:sjyblairgarden/packages/shimmer_effect_loading.dart';
import 'package:sjyblairgarden/packages/toastification.dart';
import 'package:sjyblairgarden/statics/variables/strings.dart';
import 'dart:js' as js;

List<String> moreInfoDialogStrings = Strings.moreInfoDialogStrings;
List<String> moreInfoMandRStrings = Strings.moreInfoMandRStrings;
List<String> moreInfoMandRStringsLibraries =
    Strings.moreInfoMandRStringsLibraries;
List<String> moreInfoMandRStringsFonts = Strings.moreInfoMandRStringsFonts;

class Widgets {
  static Widget pickATulipWidget(
      VariableChangeIdentifier variableChangeIdentifier,
      TextEditingController inputController) {
    return StatefulBuilder(
      builder: (
        context,
        setState,
      ) {
        final GeminiAIApiPackage geminiAIApiPackage = GeminiAIApiPackage();
        return Container(
            width: MediaQuery.of(context).size.width >= 860
                ? DynamicSizeController.calculateWidthSize(context, 0.35)
                : null,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To pick a tulip,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DynamicSizeController.calculateAspectRatioSize(
                          context, 0.020),
                      fontFamily: "CanvaSans",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 3.0, right: 115),
                    child: SelectableText(
                      "describe\nwhat you feel.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            DynamicSizeController.calculateAspectRatioSize(
                                context, .045),
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "CanvaSans",
                      ),
                    ),
                  ),
                  Container(
                    height: DynamicSizeController.calculateHeightSize(
                      context,
                      0.19,
                    ),
                    padding:
                        const EdgeInsets.only(top: 13, left: 10, right: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: DynamicSizeController.calculateHeightSize(
                            context,
                            0.20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: inputController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(
                              fontSize: 12.6,
                              fontFamily: "CanvaSans",
                              height: 1.0,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                top: 8,
                                left: 20,
                                bottom: 8,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'CanvaSans',
                                fontSize: 12.6,
                              ),
                              hintText: "Write everything out here...",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: DynamicSizeController.calculateHeightSize(
                      context,
                      0.065,
                    ),
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        String inputValue = inputController.text;
                        if (inputValue.isNotEmpty) {
                          ToastificationPackage.showLoadingToast(
                              context,
                              "We're on it!",
                              "We're working on your request and will get back to you shortly.");
                          setState(() {
                            variableChangeIdentifier
                                .pickATulipLoadingChangeCondition(true);
                          });
                          geminiAIApiPackage
                              .getTulipAndDescription(inputValue)
                              .then((recommendation) {
                            variableChangeIdentifier.pickATulipChangeValue(
                              recommendation.tulip,
                              recommendation.description,
                            );

                            setState(() {
                              variableChangeIdentifier
                                  .pickATulipLoadingChangeCondition(false);
                            });
                          });
                        } else {
                          setState(() {
                            variableChangeIdentifier
                                .pickATulipLoadingChangeCondition(true);
                          });
                          ToastificationPackage.showErrorToast(context, 'Error',
                              'Your generation request failed due to invalid queries.');
                        }
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9F8AAF),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotationTransition(
                                turns:
                                    const AlwaysStoppedAnimation(-32.2 / 360),
                                child: Image.asset(
                                  'assets/media_others/blob_https___www.canva.png',
                                  width:
                                      DynamicSizeController.calculateWidthSize(
                                          context, 0.013),
                                  height: 33.3,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'GENERATE YOUR TULIP',
                                style: TextStyle(
                                  fontFamily: "CanvaSans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  variableChangeIdentifier.pickATulipLoadingGlobal
                      ? Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.withOpacity(0.6),
                          child: const PickATulipLoading(),
                        )
                      : PickATulipUIController(
                          tulipRecommendationReceive: variableChangeIdentifier
                              .tulipRecommendationGlobal,
                          tulipDescriptionReceive:
                              variableChangeIdentifier.tulipDescriptionGlobal,
                        ),
                  const SizedBox(height: 15)
                ],
              ),
            ));
      },
    );
  }

  static Widget mobileMenuDrawerWidget(
      VariableChangeIdentifier _variableChangeIdentifier) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      _variableChangeIdentifier.pageNumberChangeValue(0);
                    });
                  },
                  child: Opacity(
                      opacity: _variableChangeIdentifier.myPage == 0 ? 0.5 : 1,
                      child: const Text(
                        "HOME",
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
                    setState(() {
                      Navigator.pop(context);
                      _variableChangeIdentifier.pageNumberChangeValue(1);
                    });
                  },
                  child: Opacity(
                      opacity: _variableChangeIdentifier.myPage == 1 ? 0.5 : 1,
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
                    setState(() {
                      Navigator.pop(context);
                      _variableChangeIdentifier.pageNumberChangeValue(2);
                    });
                  },
                  child: Opacity(
                      opacity: _variableChangeIdentifier.myPage == 2 ? 0.5 : 1,
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
                padding: const EdgeInsets.all(30),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      _variableChangeIdentifier.pageNumberChangeValue(0);
                    });
                    Widget moreInfoWidget = Widgets.moreInfoWidget();
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Dialog(
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          elevation: 0,
                          child: moreInfoWidget,
                        ),
                      ),
                    );
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
        );
      },
    );
  }

  static Widget moreInfoWidget() {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(150, 255, 247, 173),
              Color.fromARGB(150, 255, 169, 249),
            ],
          ),
          borderRadius: BorderRadius.circular(36),
        ),
        width: 600,
        height: 600,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      moreInfoDialogStrings.isNotEmpty
                          ? moreInfoDialogStrings[0]
                          : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'A Day Without Sun',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    Text(
                      moreInfoDialogStrings.length > 1
                          ? moreInfoDialogStrings[1]
                          : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            DynamicSizeController.calculateAspectRatioSize(
                                context, 0.09),
                        fontFamily: 'PonyClub',
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 5, 6, 18),
                      child: Text(
                        moreInfoDialogStrings.length > 2
                            ? moreInfoDialogStrings[2]
                            : '',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 10.9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 78.7,
                              child: Image.asset(
                                "assets/media_others/tulip_flower.png",
                                width: 28.7,
                                height: 77.5,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    moreInfoDialogStrings.length > 3
                                        ? moreInfoDialogStrings[3]
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'CanvaSans',
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        moreInfoDialogStrings.length > 4
                                            ? moreInfoDialogStrings[4]
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'CanvaSans',
                                          fontSize: 10.5,
                                          height: 1.2,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 78.7,
                              child: Image.asset(
                                "assets/media_others/amst_wall.png",
                                width: 48.7,
                                height: 97.5,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 13),
                                    child: Text(
                                      moreInfoDialogStrings.length > 5
                                          ? moreInfoDialogStrings[5]
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'CanvaSans',
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        moreInfoDialogStrings.length > 6
                                            ? moreInfoDialogStrings[6]
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'CanvaSans',
                                          fontSize: 10.5,
                                          height: 1.2,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 78.7,
                              child: Image.asset(
                                "assets/media_others/e-library_logo.png",
                                width: 18.7,
                                height: 67.5,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 13),
                                    child: Text(
                                      moreInfoDialogStrings.length > 7
                                          ? moreInfoDialogStrings[7]
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'CanvaSans',
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        moreInfoDialogStrings.length > 8
                                            ? moreInfoDialogStrings[8]
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'CanvaSans',
                                          fontSize: 10.5,
                                          height: 1.2,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Dialog(
                              backgroundColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              elevation: 0,
                              child: Widgets.moreInfoMandRWidget()),
                        ),
                      );
                    },
                    child: Text(
                      moreInfoDialogStrings.length > 9
                          ? moreInfoDialogStrings[9]
                          : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'CanvaSans',
                        fontSize:
                            DynamicSizeController.calculateAspectRatioSize(
                                context, 0.0118),
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      js.context.callMethod(
                          'open', ['https://github.com/DanRyuzaki']);
                    },
                    child: Text(
                      moreInfoDialogStrings.length > 10
                          ? moreInfoDialogStrings[10]
                          : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'CanvaSans',
                        fontSize:
                            DynamicSizeController.calculateAspectRatioSize(
                                context, 0.0118),
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      js.context.callMethod(
                          'open', ['https://buymeacoffee.com/danryuzaki']);
                    },
                    child: Text(
                      moreInfoDialogStrings.length > 11
                          ? moreInfoDialogStrings[11]
                          : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'CanvaSans',
                        fontSize:
                            DynamicSizeController.calculateAspectRatioSize(
                                context, 0.0118),
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              moreInfoDialogStrings.length > 12
                  ? moreInfoDialogStrings[12]
                  : '',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'CanvaSans',
                fontSize: 11,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }

  static Widget moreInfoMandRWidget() {
    return StatefulBuilder(builder: (context, setState) {
      if (moreInfoMandRStrings.isEmpty) return Container(); // Handle empty case

      return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(36),
        ),
        width: 600,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      moreInfoMandRStrings[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            DynamicSizeController.calculateAspectRatioSize(
                          context,
                          0.09,
                        ),
                        fontFamily: 'PonyClub',
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 5, 6, 18),
                      child: Text(
                        moreInfoMandRStrings[1],
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 10.9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "IMPORTED FONTS",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'CanvaSans',
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 5),
                              child: Text(
                                moreInfoMandRStrings[3],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CanvaSans',
                                  fontSize: 10.5,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var library in moreInfoMandRStringsFonts)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        '• $library',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'CanvaSans',
                                          fontSize: 10.5,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "THIRD PARTY LIBRARIES (PUB.DEV)",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'CanvaSans',
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 5),
                              child: Text(
                                moreInfoMandRStrings[2],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CanvaSans',
                                  fontSize: 10.5,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 5, left: 20, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var library
                                      in moreInfoMandRStringsLibraries)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        '• $library',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'CanvaSans',
                                          fontSize: 10.5,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "[ ! ]  RESPONSIBLE USE OF THIRD PARTY MATERIALS",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'CanvaSans',
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 5),
                              child: Text(
                                moreInfoMandRStrings[4],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CanvaSans',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10.5,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  static Widget DesktopBookCardContainerWidget(
      String title,
      String bookID,
      String authorName,
      String dateDisplay,
      String description,
      String bookCoverAddr,
      String readAddr) {
    return Container(
        margin: EdgeInsets.fromLTRB(70, 0, 70, 25),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(170, 70, 50, 66),
              Color.fromARGB(170, 153, 112, 107),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(27, 20, 27, 20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(106, 0, 0, 0),
                    borderRadius: BorderRadius.circular(15),
                    image:
                        DecorationImage(image: NetworkImage(bookCoverAddr)))),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 70, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          title,
                          style: TextStyle(
                              fontFamily: 'CanvaSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.white),
                        ),
                        SelectableText(
                          "$authorName • $dateDisplay • $bookID",
                          style: TextStyle(
                              fontFamily: 'CanvaSans',
                              fontSize: 13.1,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                            child: SelectableText(
                          description,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w100,
                            fontSize: 13.1,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ))),
            Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                    onTap: () {
                      js.context.callMethod('open', [readAddr]);
                    },
                    child: Material(
                      color: Colors.transparent,
                      shape:
                          CircleBorder(side: BorderSide(color: Colors.white)),
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: const Icon(
                            Icons.auto_stories,
                            color: Colors.white,
                            size: 40.0,
                          )),
                    )))
          ]),
        ));
  }

  static Widget MobileBookCardContainerWidget(
      BuildContext context,
      String title,
      String bookID,
      String authorName,
      String dateDisplay,
      String description,
      String bookCoverAddr,
      String readAddr) {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(170, 70, 50, 66),
              Color.fromARGB(170, 153, 112, 107),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(27, 20, 27, 20),
          child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MediaQuery.of(context).size.width <= 540
                  ? SizedBox()
                  : Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(106, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(bookCoverAddr)))),
              Expanded(
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            title,
                            style: TextStyle(
                                fontFamily: 'CanvaSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.white),
                          ),
                          SelectableText(
                            "Author: $authorName\nPublished: $dateDisplay\nID: $bookID",
                            style: TextStyle(
                                fontFamily: 'CanvaSans',
                                fontSize: 13.1,
                                color: Colors.white),
                          ),
                        ],
                      ))),
            ]),
            SelectableText(
              description,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w100,
                fontSize: 13.1,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    js.context.callMethod('open', [readAddr]);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "READ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "CanvaSans",
                    ),
                  ),
                ))
          ]),
        ));
  }

  static Widget MessageCardContainerWidget(Timestamp _publishedDate,
      String _message, Color _color, Timestamp _disposalDate) {
    Timestamp publishedDate = _publishedDate;
    dynamic message = _message;
    Color color = _color;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
            color: color,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: SelectableText(
                      message,
                      style: TextStyle(
                          fontFamily: 'CanvaSans',
                          fontSize: 12,
                          color: Colors.black),
                      textAlign: TextAlign.start,
                    )),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "${publishedDate.toDate().toString()}",
                    style: TextStyle(
                        fontFamily: 'CanvaSans',
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.black),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
