import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:sakura_blizzard/sakura_blizzard.dart';
import 'package:sjyblairgarden/main.dart';

class BackgroundController extends StatelessWidget {
  const BackgroundController({super.key});

  @override
  Widget build(BuildContext context) {
    final VariableChangeIdentifier variableChangeIdentifier =
        Provider.of<VariableChangeIdentifier>(context);

    switch (variableChangeIdentifier.myPage) {
      case 0:
        return Stack(
          children: [
            SakuraBlizzardView(
                viewSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                fps: 60,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/media_background/home-background-photo-tulips-stable.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ],
        );
      case 1:
        return Stack(
          children: [
            Animate(
                effects: [ShimmerEffect(delay: 300.ms, duration: 1500.ms)],
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/media_background/amstwall-background-photo-tulips-stable.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })).animate().blurXY(begin: 1.5, end: 1.5),
          ],
        );
      case 2:
        return Stack(
          children: [
            Animate(
                effects: [ShimmerEffect(delay: 300.ms, duration: 1500.ms)],
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/media_background/elibrary-background-photo-tulips-stable.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })).animate().blurXY(begin: 1, end: 1),
          ],
        );
      default:
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/media_background/home-background-photo-tulips-stable.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
    }
  }
}
