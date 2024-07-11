import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sjyblairgarden/controllers/firestore_errors_controller.dart';
import 'package:sjyblairgarden/packages/toastification.dart';

class AmstwallMessageController extends StatefulWidget {
  const AmstwallMessageController({Key? key}) : super(key: key);

  @override
  State<AmstwallMessageController> createState() =>
      AmstwallMessageControllerState();
}

class WallMessageModel {
  final Timestamp publishedDate;
  final String message;
  final dynamic color;
  final Timestamp disposalDate;

  WallMessageModel(
      this.publishedDate, this.message, this.color, this.disposalDate);
}

class AmstwallMessageControllerState extends State<AmstwallMessageController> {
  List<WallMessageModel> WallMessages = [];
  List<WallMessageModel> WallDisplayedMessages = [];

  Future<void> AmsterdamWallFirestoreInit() async {
    try {
      CollectionReference bookCollections =
          FirebaseFirestore.instance.collection('AmsterdamWall');
      QuerySnapshot querySnapshot = await bookCollections.get();
      for (var doc in querySnapshot.docs) {
        WallMessages.add(WallMessageModel(doc.get('publishedDate'),
            doc.get('message'), doc.get('color'), doc.get('disposalDate')));
      }
      setState(() {
        WallDisplayedMessages = WallMessages;
      });
      ToastificationPackage.showLoadingToast(
          context, "Loaded", "Messages loaded successfully");
    } catch (e) {
      FirestoreErrorsController.firestoreErrorsController(
          e.toString(), 'Firestore@AmsterdamWall');
      ToastificationPackage.showLoadingToast(context, "Error",
          "Failed to load messages. Please contact the developer for investigation.");
    }
  }

  Widget MessageCardContainer() {
    double containerHeightSize = 339.7;
    double containerWidthSize = 280;
    return Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: containerWidthSize,
            childAspectRatio: containerWidthSize / containerHeightSize,
          ),
          itemCount: WallDisplayedMessages.length,
          itemBuilder: (context, index) {
            final wallMessage = WallDisplayedMessages[index];
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                    color: wallMessage.color,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: SelectableText(
                              wallMessage.message,
                              style: TextStyle(
                                  fontFamily: 'CanvaSans',
                                  fontSize: 12,
                                  color: Colors.black),
                              textAlign: TextAlign.start,
                            )),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${wallMessage.publishedDate}",
                            style: TextStyle(
                                fontFamily: 'CanvaSans',
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  )),
            );
          },
        ));
  }

  static Color AmstwallMessageColorPicker() {
    List<Color> colors = [
      Color(0xFFFFDE59),
      Color(0xFF7ED957),
      Color(0xFFCB6CE6),
      Color(0xFF5271FF),
      Color(0xFFFF914D),
      Color(0xFFC1FF72)
    ];
    Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
