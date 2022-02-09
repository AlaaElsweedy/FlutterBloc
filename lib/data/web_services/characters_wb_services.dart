import '../../helpers/dio_helper.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  static Future<List<dynamic>> getAllCharacters() async {
    Response response = await DioHelper.getData(url: 'characters');
    return response.data;
  }

  static Future<List<dynamic>> getQuates({
    required String charName,
  }) async {
    Response response = await DioHelper.getData(
      url: 'quote',
      query: {
        'author': charName,
      },
    );
    return response.data;
  }
}
