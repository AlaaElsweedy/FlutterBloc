part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetAllCharactersSuccess extends AppState {}

class GetQuoteSuccess extends AppState {}

class SearchCharactersSuccess extends AppState {}

class ChangeSearchingState extends AppState {}

class ClearSearchedCharacters extends AppState {}
