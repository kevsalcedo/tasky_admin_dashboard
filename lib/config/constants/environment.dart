import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String openaAIKey =
      dotenv.env['OPENAI_API_KEY'] ?? 'No api key';
}
