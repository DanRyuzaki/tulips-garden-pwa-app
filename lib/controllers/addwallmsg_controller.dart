import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sjyblairgarden/controllers/firestore_errors_controller.dart';
import 'package:sjyblairgarden/packages/toastification.dart';

class AddMessageCardContainer extends StatefulWidget {
  final String color;
  final bool clicked;
  final VoidCallback addMsgOnTap;
  final VoidCallback updateGridViewData;

  const AddMessageCardContainer({
    Key? key,
    required this.color,
    required this.clicked,
    required this.addMsgOnTap,
    required this.updateGridViewData,
  }) : super(key: key);

  @override
  _AddMessageCardContainerState createState() =>
      _AddMessageCardContainerState();
}

class _AddMessageCardContainerState extends State<AddMessageCardContainer> {
  List<Color> colors = [
    Color(0xFFFFDE59), //0
    Color(0xFF7ED957), //1
    Color(0xFFCB6CE6), //2
    Color(0xFF8FA3FD), //3
    Color(0xFFFF914D), //4
    Color(0xFFC1FF72), //5
  ];
  TextEditingController messageController = TextEditingController();
  int _charCount = 0;
  int _maxChars = 300;
  Future<void> AmsterdamWallFirestoreWriteInit(String message) async {
    CollectionReference msgCollections =
        FirebaseFirestore.instance.collection('AmsterdamWall');

    if (message != '')
      try {
        msgCollections.add({
          'publishedDate': Timestamp.fromDate(DateTime.now()),
          'message': message,
          'color': widget.color,
          'disposalDate':
              Timestamp.fromDate(DateTime.now().add(Duration(days: 7)))
        });
        widget.updateGridViewData();
        ToastificationPackage.showLoadingToast(
            context, "Uploaded", "Message uploaded successfully.");
      } catch (e) {
        FirestoreErrorsController.firestoreErrorsController(
            e.toString(), 'Firestore@AmsterdamWall.Write');
        ToastificationPackage.showLoadingToast(context, "Error",
            "Failed to upload your message. Please contact the developer for investigation.");
      }
    else
      ToastificationPackage.showErrorToast(context, "Error",
          "Your generation request failed due to invalid queries.");
  }

  @override
  void initState() {
    super.initState();
    messageController.addListener(_updateCharCount);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _updateCharCount() {
    setState(() {
      _charCount = messageController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.clicked
        ? Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: colors[int.parse(widget.color)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      maxLength: _maxChars,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\n')),
                      ],
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontFamily: 'CanvaSans', fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Enter message here...',
                        counterText: '',
                        hintStyle: TextStyle(
                          fontFamily: 'CanvaSans',
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (text) {
                        _updateCharCount();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: Row(
                      children: [
                        Text(
                          '$_charCount/$_maxChars',
                          style: TextStyle(
                            fontFamily: 'CanvaSans',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Spacer(),
                        MediaQuery.of(context).size.width <= 930
                            ? SizedBox()
                            : Text(
                                '1 week before disposal',
                                style: TextStyle(
                                  fontFamily: 'CanvaSans',
                                  fontSize: 9,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                        SizedBox(width: 4),
                        InkWell(
                            onTap: () {
                              AmsterdamWallFirestoreWriteInit(
                                  messageController.text);
                              messageController.clear();
                            },
                            child: Icon(Icons.send, color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: widget.addMsgOnTap,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: colors[int.parse(widget.color)],
                ),
                child: Center(
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
  }
}
