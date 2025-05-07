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
      // TODO: Implement API call
      final chatId = _getChatId(message.senderId, message.receiverId);
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

  Future<bool> markAsRead(String messageId, String chatId) async {
    try {
      final messages = _chats[chatId];
      if (messages != null) {
        final index = messages.indexWhere((m) => m.id == messageId);
        if (index != -1) {
          messages[index] = messages[index].copyWith(isRead: true);
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error marking message as read: $e');
      return false;
    }
  }

  String _getChatId(String userId1, String userId2) {
    final sortedIds = [userId1, userId2]..sort();
    return '${sortedIds[0]}_${sortedIds[1]}';
  }
}