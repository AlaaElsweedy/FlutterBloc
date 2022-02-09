import '../../business_logic/cubit/app_cubit.dart';
import '../../constants/colors.dart';
import '../widgets/character_item.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final _searchTextController = TextEditingController();
  bool _isSearching = false;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var allCharacters = AppCubit.get(context).characters;
        var searchedCharacters = AppCubit.get(context).searchedCharacters;

        return OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;

            if (!connected) {
              return buildNoInternetWidget();
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: _isSearching
                      ? builfTextFieldAppBar(context, cubit)
                      : const Text('Characters'),
                  backgroundColor: myYellow,
                  actions: [
                    buildAppBarActions(context, cubit),
                  ],
                ),
                body: BuildCondition(
                  condition: allCharacters.isNotEmpty,
                  builder: (context) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      shrinkWrap: true,
                      //ClampingScrollPhysics()
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _searchTextController.text.isEmpty
                          ? allCharacters.length
                          : searchedCharacters.length,
                      itemBuilder: (context, index) {
                        return CharacterItem(
                          character: _searchTextController.text.isEmpty
                              ? allCharacters[index]
                              : searchedCharacters[index],
                        );
                      },
                    );
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Can\'t connect .. check internet',
            style: TextStyle(
              fontSize: 22,
              color: myGrey,
            ),
          ),
          Image.asset('assets/images/no_internet.png'),
        ],
      ),
    );
  }

  TextField builfTextFieldAppBar(BuildContext context, cubit) {
    return TextField(
      controller: _searchTextController,
      cursorColor: myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: myGrey, fontSize: 18),
      onChanged: (characterName) {
        cubit.searchCharacter(characterName);
      },
    );
  }

  IconButton buildAppBarActions(BuildContext context, cubit) {
    return IconButton(
      onPressed: () {
        cubit.iconClicked(_isSearching = true);
        ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
          onRemove: () {
            cubit.iconClicked(_isSearching = false);
          },
        ));
      },
      icon: _isSearching
          ? IconButton(
              onPressed: () {
                _searchTextController.clear();
                cubit.clearCharacters();
              },
              icon: const Icon(
                Icons.clear,
              ))
          : const Icon(
              Icons.search,
            ),
    );
  }
}
