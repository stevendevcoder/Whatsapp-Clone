import 'package:dio/dio.dart';
import 'package:tes_no_app/models/chat_model.dart';
import 'package:tes_no_app/models/yes_no_model.dart';


class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    return yesNoModel.toMessageEntity();
  }
}