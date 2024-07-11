import 'package:flutter/material.dart';

class PickATulipUIController extends StatefulWidget {
  final String tulipRecommendationReceive;
  final String tulipDescriptionReceive;

  PickATulipUIController({
    super.key,
    required this.tulipRecommendationReceive,
    required this.tulipDescriptionReceive,
  });

  final Map<String, String> tulipRecommendationImgUrl = {
    'Yellow Tulip': 'assets/media_pick-a-tulip/Yellow_Tulip.png',
    'Orange Tulip': 'assets/media_pick-a-tulip/Orange_Tulip.png',
    'White Tulip': 'assets/media_pick-a-tulip/White_Tulip.png',
    'Pink Tulip': 'assets/media_pick-a-tulip/Pink_Tulip.png',
    'Red Tulip': 'assets/media_pick-a-tulip/Red_Tulip.png',
    'Purple Tulip': 'assets/media_pick-a-tulip/Purple_Tulip.png',
    'ERROR-CODE_800': '',
    'ERROR-CODE_801': '',
    'ERROR-CODE_802': '',
    'ERROR-CODE_803': ''
  };

  @override
  State<PickATulipUIController> createState() => PickATulipControllerActivity();
}

class PickATulipControllerActivity extends State<PickATulipUIController> {
  late final String tulipRecommendation;
  late final String tulipDescription;
  late final String tulipImgAddress;

  @override
  void initState() {
    super.initState();

    tulipRecommendation = widget.tulipRecommendationReceive.toUpperCase();
    tulipDescription = widget.tulipDescriptionReceive;
    tulipImgAddress =
        widget.tulipRecommendationImgUrl[widget.tulipRecommendationReceive] ??
            '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: MediaQuery.of(context).size.width >= 500
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tulipImgAddress == ''
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Image.asset(
                            tulipImgAddress,
                            fit: BoxFit.contain,
                            width: 114.8,
                            height: 214,
                          ),
                        ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SelectableText(
                          tulipRecommendation.startsWith('ERROR-CODE')
                              ? tulipRecommendation
                              : "YOU DESERVE A BOUQUET OF ${tulipRecommendation}S!",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF8C52FF),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SelectableText(
                            tulipDescription,
                            style: const TextStyle(
                              fontFamily: "CanvaSans",
                              fontSize: 12.2,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tulipImgAddress == ''
                      ? const SizedBox()
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Image.asset(
                            tulipImgAddress,
                            fit: BoxFit.contain,
                            width: 94.8,
                            height: 194,
                          ),
                        )),
                  SelectableText(
                    tulipRecommendation.startsWith('ERROR-CODE')
                        ? tulipRecommendation
                        : "YOU DESERVE A BOUQUET OF ${tulipRecommendation}S!",
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF8C52FF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SelectableText(
                      tulipDescription,
                      style: const TextStyle(
                        fontFamily: "CanvaSans",
                        fontSize: 12.2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ));
  }
}
