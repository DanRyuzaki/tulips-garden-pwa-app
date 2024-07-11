import 'package:flutter/material.dart';
import 'package:sjyblairgarden/controllers/dynamicsize_controller.dart';

class ShimmerEffectLoading extends StatelessWidget {
  const ShimmerEffectLoading({super.key, this.height, this.width});

  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
    );
  }
}

class PickATulipLoading extends StatelessWidget {
  const PickATulipLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          ShimmerEffectLoading(
              height:
                  DynamicSizeController.calculateHeightSize(context, 0.2943),
              width: DynamicSizeController.calculateWidthSize(context, 0.1567)),
          SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffectLoading(height: 15, width: 210),
              SizedBox(height: 15),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13),
              SizedBox(height: 10),
              ShimmerEffectLoading(height: 13, width: 100),
              SizedBox(height: 10)
            ],
          )),
        ],
      ),
    );
  }
}

class ELibraryLoading extends StatelessWidget {
  const ELibraryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: DynamicSizeController.calculateHeightSize(context, 0.28),
        margin: MediaQuery.of(context).size.width <= 730
            ? EdgeInsets.fromLTRB(15, 0, 15, 25)
            : EdgeInsets.fromLTRB(70, 0, 70, 25),
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
            child: Row(children: [
              MediaQuery.of(context).size.width >= 730
                  ? ShimmerEffectLoading(
                      height: DynamicSizeController.calculateHeightSize(
                          context, 0.23),
                      width: DynamicSizeController.calculateWidthSize(
                          context, 0.108),
                    )
                  : SizedBox(),
              Expanded(
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            ShimmerEffectLoading(
                              height: DynamicSizeController.calculateHeightSize(
                                  context, 0.04),
                              width: DynamicSizeController.calculateWidthSize(
                                  context, 0.108),
                            ),
                            SizedBox(height: 10),
                            ShimmerEffectLoading(
                                height:
                                    DynamicSizeController.calculateHeightSize(
                                        context, 0.029),
                                width: DynamicSizeController.calculateWidthSize(
                                    context, 0.60)),
                            SizedBox(height: 5),
                            ShimmerEffectLoading(
                                height:
                                    DynamicSizeController.calculateHeightSize(
                                        context, 0.029),
                                width: DynamicSizeController.calculateWidthSize(
                                    context, 0.60)),
                            SizedBox(height: 5),
                            ShimmerEffectLoading(
                                height:
                                    DynamicSizeController.calculateHeightSize(
                                        context, 0.029),
                                width: DynamicSizeController.calculateWidthSize(
                                    context, 0.30)),
                          ])))
            ])));
  }
}
