import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sjyblairgarden/controllers/addwallmsg_controller.dart';
import 'package:sjyblairgarden/controllers/dynamicsize_controller.dart';
import 'package:sjyblairgarden/controllers/firestore_errors_controller.dart';
import 'package:sjyblairgarden/packages/toastification.dart';
import 'package:sjyblairgarden/statics/others/widgets.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class AmstWallRoute extends StatefulWidget {
  const AmstWallRoute({super.key});

  @override
  State<AmstWallRoute> createState() => AmstWallRouteActivity();
}

class WallMessageModel {
  final bool addYoursButton;
  final Timestamp publishedDate;
  final String message;
  final dynamic color;
  final Timestamp disposalDate;

  WallMessageModel(this.addYoursButton, this.publishedDate, this.message,
      this.color, this.disposalDate);
}

class AmstWallRouteActivity extends State<AmstWallRoute> {
  List<WallMessageModel> WallMessages = [];
  List<WallMessageModel> WallDisplayedMessages = [];
  List<Color> colors = [
    Color(0xFFFFDE59), //0
    Color(0xFF7ED957), //1
    Color(0xFFCB6CE6), //2
    Color(0xFF8FA3FD), //3
    Color(0xFFFF914D), //4
    Color(0xFFC1FF72), //5
  ];
  bool clicked = false;
  bool pageAlreadySpawned = false;
  late String colorPicked;

  @override
  void initState() {
    super.initState();
    colorPicked = AmstwallMessageColorPicker();
    launchAddYoursWidget();
    AmsterdamWallFirestoreReadInit();
  }

  void launchAddYoursWidget() {
    WallMessages.add(WallMessageModel(
        true,
        Timestamp.fromDate(DateTime.parse('2030-07-05 12:34:56')),
        '',
        colorPicked,
        Timestamp.fromDate(DateTime.parse('2030-07-05 12:34:56'))));
    WallDisplayedMessages.add(WallMessageModel(
        true,
        Timestamp.fromDate(DateTime.parse('2030-07-05 12:34:56')),
        '',
        colorPicked,
        Timestamp.fromDate(DateTime.parse('2030-07-05 12:34:56'))));
  }

  Future<void> AmsterdamWallFirestoreReadInit() async {
    try {
      CollectionReference msgCollections =
          FirebaseFirestore.instance.collection('AmsterdamWall');
      QuerySnapshot querySnapshot = await msgCollections.get();
      for (var doc in querySnapshot.docs) {
        WallMessages.add(WallMessageModel(false, doc.get('publishedDate'),
            doc.get('message'), doc.get('color'), doc.get('disposalDate')));
      }
      setState(() {
        List<WallMessageModel> WallMessagesFiltered = List.from(WallMessages);
        WallMessagesFiltered.sort(
            (a, b) => b.publishedDate.compareTo(a.publishedDate));
        WallDisplayedMessages = WallMessagesFiltered.toList();
      });
      pageAlreadySpawned == false
          ? ToastificationPackage.showLoadingToast(
              context, "Loaded", "Messages loaded successfully.")
          : null;
    } catch (e) {
      FirestoreErrorsController.firestoreErrorsController(
          e.toString(), 'Firestore@AmsterdamWall.Read');
      ToastificationPackage.showLoadingToast(context, "Error",
          "Failed to load messages. Please contact the developer for investigation.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: TextAnimator(
                "Amsterdam Wall",
                atRestEffect: WidgetRestingEffects.wave(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: DynamicSizeController.calculateAspectRatioSize(
                        context, 0.0856),
                    fontFamily: 'PonyClub'),
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
                onTap: () {
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Beyond everything, release it all here.",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DynamicSizeController.calculateAspectRatioSize(
                          context, 0.011),
                      fontFamily: 'Montserrat',
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 20.0,
                  )
                ])),
          ),
          SizedBox(height: 25),
          Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 280,
                        childAspectRatio: 280 / 339.7,
                      ),
                      itemCount: WallDisplayedMessages.length,
                      itemBuilder: (context, index) {
                        final wallmsg = WallDisplayedMessages[index];
                        return wallmsg.addYoursButton == false
                            ? Widgets.MessageCardContainerWidget(
                                wallmsg.publishedDate,
                                wallmsg.message,
                                colors[int.parse(wallmsg.color)],
                                wallmsg.disposalDate,
                              )
                            : AddMessageCardContainer(
                                color: colorPicked,
                                clicked: clicked,
                                addMsgOnTap: () {
                                  setState(() {
                                    clicked = true;
                                  });
                                },
                                updateGridViewData: () {
                                  setState(() {
                                    pageAlreadySpawned = true;
                                    WallMessages = [];
                                    colorPicked = AmstwallMessageColorPicker();
                                    AmsterdamWallFirestoreReadInit();
                                    clicked = false;
                                    launchAddYoursWidget();
                                  });
                                },
                              );
                      },
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  String AmstwallMessageColorPicker() {
    Random random = Random();
    return "${random.nextInt(colors.length)}";
  }
}
