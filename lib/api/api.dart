import 'package:http/http.dart' as http;
import 'package:mvc2_card_game/models/character.dart';
import 'package:mvc2_card_game/models/move.dart';

final client = http.Client();
final baseUrl = 'https://secure-hamlet-19722.herokuapp.com/api/v1/characters/';

class Api {
  static Future<Character> getCharacter(String name) async {
    final url = Uri.parse(baseUrl + '$name');
    try {
      final response = await client.get(url) as Map<String, dynamic>;
      return Character.fromJson(response);
    } catch (error) {
      print("error fetching api $error");
      return Future<Character>.value(Character(
          headShot:
              "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg",
          name: 'Unknown',
          universe: 'Uknown'));
    }
  }

  static Future<Move> getMoves(String name) async {
    final url = Uri.parse(baseUrl + '$name');
    try {
      final response = await client.get(url) as Map<String, dynamic>;
      return Move.fromJson(response);
    } catch (error) {
      print("error fetching api $error");
      return Future<Move>.value(Move());
    }
  }

  static Future<List<Character>> getAllCharacters() async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await client.get(url) as List<Map<String, dynamic>>;
      return response
          .map((character) => Character.fromJson(character))
          .toList();
    } catch (error) {
      print("error fetching api $error");
      return [];
    }
  }
}
