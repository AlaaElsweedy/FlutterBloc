import '../../data/models/characters_model.dart';
import '../../data/models/quote.dart';
import '../../data/repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Character> characters = [];
  List<Character> searchedCharacters = [];
  List<Quote> quotes = [];

  List<Character> getAllCharacters() {
    CharactersRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(GetAllCharactersSuccess());
    });
    return characters;
  }

  List<Quote> getQuotes(String charName) {
    CharactersRepository.getQuates(charName).then((quotes) {
      this.quotes = quotes;
      emit(GetQuoteSuccess());
    });
    return quotes;
  }

  void searchCharacter(String searchCharacter) {
    searchedCharacters = characters
        .where((character) =>
            character.name.toLowerCase().contains(searchCharacter))
        .toList();
    emit(SearchCharactersSuccess());
  }

  void iconClicked(bool isSearching) {
    emit(ChangeSearchingState());
  }

  void clearCharacters() {
    emit(ClearSearchedCharacters());
  }
}
