import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/app_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/characters_model.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //BlocProvider.of<AppCubit>(context).getQuotes(character.name);

    return Scaffold(
      backgroundColor: myGrey,
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch(accentColor: myGrey),
        ),
        child: CustomScrollView(
          slivers: [
            buildSliverAppBar(height * 0.8),
            buildSliverList(),
          ],
        ),
      ),
    );
  }

  Widget buildSliverAppBar(var height) {
    return SliverAppBar(
      backgroundColor: myYellow,
      elevation: 0,
      // stretch: true,
      pinned: true,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: const TextStyle(color: myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildSliverList() {
    return SliverList(
        delegate: SliverChildListDelegate(
      [
        Container(
          margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCharacterInfo(
                title: 'Job: ',
                value: character.jobs.join(" / "),
              ),
              myDivider(325.0),
              buildCharacterInfo(
                title: 'Appered In: ',
                value: character.apperedIn,
              ),
              myDivider(265.0),
              character.breakingBadSeasons.isNotEmpty
                  ? buildCharacterInfo(
                      title: 'Breaking Bad Seasons: ',
                      value: character.breakingBadSeasons.join(" / "),
                    )
                  : Container(),
              character.breakingBadSeasons.isNotEmpty
                  ? myDivider(285.0)
                  : Container(),
              character.betterCallSaulAppearanceSeasons.isNotEmpty
                  ? buildCharacterInfo(
                      title: 'Better Call Saul Seasons: ',
                      value:
                          character.betterCallSaulAppearanceSeasons.join(" / "),
                    )
                  : Container(),
              character.betterCallSaulAppearanceSeasons.isNotEmpty
                  ? myDivider(240.0)
                  : Container(),
              buildCharacterInfo(
                title: 'Status: ',
                value: character.statusIfDeadOrAlive,
              ),
              myDivider(300.0),
              buildCharacterInfo(
                title: 'Actor/Actress: ',
                value: character.acotrName,
              ),
              myDivider(240.0),
              const SizedBox(height: 20),
              buildRandomQuote(),
            ],
          ),
        ),
        const SizedBox(height: 500),
      ],
    ));
  }

  BlocBuilder<AppCubit, AppState> buildRandomQuote() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is! GetQuoteSuccess) {
          return const Center(
            child: CircularProgressIndicator(
              color: myYellow,
            ),
          );
        }
        var quotes = AppCubit.get(context).quotes;

        return BuildCondition(
          condition: quotes.isNotEmpty,
          builder: (context) {
            int randomQuoteIndex = Random().nextInt(quotes.length - 1);
            return Center(
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: myWhite,
                  shadows: [
                    Shadow(
                      blurRadius: 7,
                      color: myYellow,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText(
                      quotes[randomQuoteIndex].quote,
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Container(),
        );
      },
    );
  }

  Widget buildCharacterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: myWhite,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget myDivider(double lineWidth) {
    return Divider(
      thickness: 3,
      height: 30,
      endIndent: lineWidth,
      color: myYellow,
    );
  }
}
