import 'package:dio/dio.dart';
import 'package:flurchat/model/chat_model.dart';

abstract class Service {
  Dio dio = Dio();
  String baseurl = "https://664dcb37ede9a2b55654e96c.mockapi.io/api/v1/people";
  Future<List<ChatModel>> getChat();
}

class ChatServiceImp extends Service {
  @override
  Future<List<ChatModel>> getChat() async {
    try {
      Response response = await dio.get(baseurl);
      if (response.statusCode == 200) {
        print(response.data);
        List<ChatModel> chats = List.generate(
          response.data.length,
          (index) => ChatModel.fromMap(response.data[index]),
        );
        return chats;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print("Dio Exception: ${e.message}");
      return [];
    } catch (e) {
      print("General error: $e");
      return [];
    }
  }
}
