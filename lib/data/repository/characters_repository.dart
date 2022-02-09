import '../models/characters_model.dart';
import '../models/quote.dart';
import '../web_services/characters_wb_services.dart';

class CharactersRepository {
  static Future<List<Character>> getAllCharacters() async {
    final characters = await CharactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  static Future<List<Quote>> getQuates(String charName) async {
    final quotes = await CharactersWebServices.getQuates(charName: charName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
