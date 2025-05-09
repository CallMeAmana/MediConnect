import 'package:flutter/foundation.dart';
import 'package:mediconnect/models/message.dart';

class ChatProvider with ChangeNotifier {
  Map<String, List<Message>> _chats = {};

  List<Message> getMessages(String userId1, String userId2) {
    final chatId = _getChatId(userId1, userId2);
    return _chats[chatId] ?? [];
  }

  Future<bool> sendMessage(Message message) async {
    try {
      final chatId = _getChatId(message.senderId, message.receiverId ?? '');
      if (!_chats.containsKey(chatId)) {
        _chats[chatId] = [];
      }
      _chats[chatId]!.add(message);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }

  String _getChatId(String userId1, String userId2) {
    final sortedIds = [userId1, userId2]..sort();
    return '${sortedIds[0]}_${sortedIds[1]}';
  }
}