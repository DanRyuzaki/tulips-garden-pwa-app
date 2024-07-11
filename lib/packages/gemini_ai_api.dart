import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sjyblairgarden/statics/variables/strings.dart';

class GeminiAIApiPackage {
  static const Map<String, String> feelingToTulipMap = {
    'happy': 'Yellow Tulip',
    'joyful': 'Yellow Tulip',
    'excited': 'Orange Tulip',
    'energetic': 'Orange Tulip',
    'calm': 'White Tulip',
    'peaceful': 'White Tulip',
    'loved': 'Pink Tulip',
    'romantic': 'Pink Tulip',
    'passionate': 'Red Tulip',
    'sad': 'Purple Tulip',
    'lonely': 'Purple Tulip',
    'frustrated': 'Purple Tulip',
    'errorA': 'ERROR-CODE_800',
    'errorB': 'ERROR-CODE_801',
    'errorC': 'ERROR-CODE_802',
    'errorD': 'ERROR-CODE_803'
  };

  Future<String> getTulipRecommendation(String inputValue) async {
    String feeling = "errorA";
    String prompt =
        "A = \"$inputValue\"; based on variable A, what feeling am I showing? I am 'happy', 'joyful', 'excited', 'energetic', 'calm', 'peaceful', 'loved', 'romantic', 'passionate', 'sad', 'lonely', 'frustrated'. Prompt rule: only choose, no explanation. ";
    Gemini.instance.streamGenerateContent(prompt).listen((value) {
      feeling = value.output ?? "errorB";
    }).onError((e) {
      feeling = "errorC";
    });
    await Future.delayed(const Duration(seconds: 5));
    return feelingToTulipMap[feeling.toLowerCase()] ?? 'ERROR-CODE_803';
  }

  Future<TulipRecommendation> getTulipAndDescription(String feeling) async {
    final tulip = await getTulipRecommendation(feeling);
    const List<String> tulipDescription = Strings.tulipDescription;
    const List<String> pickAtulipErrorDescription =
        Strings.pickAtulipErrorDescription;
    String description;
    switch (tulip) {
      case 'Yellow Tulip':
        description = tulipDescription[0];
        break;
      case 'Orange Tulip':
        description = tulipDescription[1];
        break;
      case 'White Tulip':
        description = tulipDescription[2];
        break;
      case 'Pink Tulip':
        description = tulipDescription[3];
        break;
      case 'Red Tulip':
        description = tulipDescription[4];
        break;
      case 'Purple Tulip':
        description = tulipDescription[5];
        break;

      //errors:
      case 'ERROR-CODE_800':
        description = pickAtulipErrorDescription[0];
        break;
      case 'ERROR-CODE_801':
        description = pickAtulipErrorDescription[1];
        break;
      case 'ERROR-CODE_802':
        description = description = pickAtulipErrorDescription[2];
        break;
      case 'errorD' || 'ERROR-CODE_803':
        description = description = pickAtulipErrorDescription[3];
        break;
      default:
        description = 'Tulip recommendation not found.';
    }
    return TulipRecommendation(tulip: tulip, description: description);
  }
}

class TulipRecommendation {
  final String tulip;
  final String description;

  TulipRecommendation({required this.tulip, required this.description});
}
