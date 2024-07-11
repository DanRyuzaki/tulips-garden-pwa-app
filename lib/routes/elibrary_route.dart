import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sjyblairgarden/controllers/dynamicsize_controller.dart';
import 'package:sjyblairgarden/controllers/firestore_errors_controller.dart';
import 'package:sjyblairgarden/packages/shimmer_effect_loading.dart';
import 'package:sjyblairgarden/packages/toastification.dart';
import 'package:sjyblairgarden/statics/others/widgets.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'dart:js' as js;

class ElibraryRoute extends StatefulWidget {
  const ElibraryRoute({super.key});

  @override
  State<ElibraryRoute> createState() => ElibraryRouteActivity();
}

class BookModel {
  final String title;
  final String bookID;
  final String authorName;
  final String dateDisplay;
  final String description;
  final String bookCoverAddr;
  final String readAddr;

  BookModel(this.title, this.bookID, this.authorName, this.dateDisplay,
      this.description, this.bookCoverAddr, this.readAddr);
}

class ElibraryRouteActivity extends State<ElibraryRoute> {
  List<BookModel> bookData = [];
  List<BookModel> displayedBooks = [];
  late bool isPageLoaded;
  String query = '';

  @override
  void initState() {
    super.initState();
    isPageLoaded = false;
    BooksFirestoreInit();
  }

  Future<void> BooksFirestoreInit() async {
    try {
      CollectionReference bookCollections =
          FirebaseFirestore.instance.collection('Books');
      QuerySnapshot querySnapshot = await bookCollections.get();
      for (var doc in querySnapshot.docs) {
        bookData.add(BookModel(
            doc.get('title'),
            doc.get('bookID'),
            doc.get('authorName'),
            doc.get('dateDisplay'),
            doc.get('description'),
            doc.get('bookCoverAddr'),
            doc.get('readAddr')));
      }
      setState(() {
        displayedBooks = displayWhenQueryPassive();
        isPageLoaded = true;
      });
      ToastificationPackage.showLoadingToast(
          context, "Loaded", "Books loaded successfully");
    } catch (e) {
      FirestoreErrorsController.firestoreErrorsController(
          e.toString(), 'Firestore@ELibrary');
      ToastificationPackage.showLoadingToast(context, "Error",
          "Failed to load books. Please contact the developer for investigation.");
    }
  }

  List<BookModel> displayWhenQueryPassive() {
    List<BookModel> booksDisplayedWhenQueryPassive = List.from(bookData);
    booksDisplayedWhenQueryPassive.sort((a, b) => b.bookID.compareTo(a.bookID));
    return booksDisplayedWhenQueryPassive.take(10).toList();
  }

  void displayWhenQueryActive(String query) {
    setState(() {
      this.query = query;
      if (query.isEmpty) {
        displayedBooks = displayWhenQueryPassive();
      } else {
        displayedBooks = bookData
            .where((book) =>
                book.title.toLowerCase().contains(query.toLowerCase()) ||
                book.bookID.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
            child: TextAnimator(
              "Electronic-Library",
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
                  "Read indie-books published by 21st-century aspiring writers!",
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlinedButton(
            onPressed: () {
              js.context
                  .callMethod('open', ['https://forms.gle/cAeHPtyDPa7DJ1iS7']);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 1),
              padding: const EdgeInsets.all(-2),
            ),
            child: Icon(
              Icons.upload,
              color: Colors.white,
              size: DynamicSizeController.calculateAspectRatioSize(
                  context, 0.020),
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 260,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: displayWhenQueryActive,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: DynamicSizeController.calculateAspectRatioSize(
                    context, 0.0126),
                fontFamily: "CanvaSans",
                height: 1.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 20,
                  right: 10,
                  bottom: 20,
                ),
                hintStyle: TextStyle(
                  fontFamily: 'CanvaSans',
                  fontSize: DynamicSizeController.calculateAspectRatioSize(
                      context, 0.0126),
                ),
                hintText: "Search your favorite indie-books...",
              ),
            ),
          ),
          SizedBox(width: 30),
        ]),
        SizedBox(height: 25),
        isPageLoaded == false
            ? Shimmer.fromColors(
                baseColor: Color.fromARGB(170, 153, 112, 107),
                highlightColor:
                    Color.fromARGB(170, 70, 50, 66).withOpacity(0.6),
                child: Column(children: [ELibraryLoading(), ELibraryLoading()]))
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayedBooks.length,
                itemBuilder: (context, index) {
                  final book = displayedBooks[index];
                  //530
                  return MediaQuery.of(context).size.width <= 730
                      ? Widgets.MobileBookCardContainerWidget(
                          //mobile size
                          context,
                          book.title,
                          book.bookID,
                          book.authorName,
                          book.dateDisplay,
                          book.description,
                          book.bookCoverAddr,
                          book.readAddr)
                      : Widgets.DesktopBookCardContainerWidget(
                          //desktop size
                          book.title,
                          book.bookID,
                          book.authorName,
                          book.dateDisplay,
                          book.description,
                          book.bookCoverAddr,
                          book.readAddr);
                },
              ),
      ],
    ));
  }
}
