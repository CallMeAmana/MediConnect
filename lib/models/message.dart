import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final String? receiverId; // null for forum posts
  final bool isForumPost;
  final List<String>? likes;
  final List<Message>? replies;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.receiverId,
    this.isForumPost = false,
    this.likes,
    this.replies,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      content: data['content'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      receiverId: data['receiverId'],
      isForumPost: data['isForumPost'] ?? false,
      likes: List<String>.from(data['likes'] ?? []),
      replies: data['replies'] != null
          ? List<Message>.from(
              (data['replies'] as List).map((x) => Message.fromMap(x)))
          : null,
    );
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      receiverId: map['receiverId'],
      isForumPost: map['isForumPost'] ?? false,
      likes: List<String>.from(map['likes'] ?? []),
      replies: map['replies'] != null
          ? List<Message>.from(
              (map['replies'] as List).map((x) => Message.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'receiverId': receiverId,
      'isForumPost': isForumPost,
      'likes': likes ?? [],
      'replies': replies?.map((x) => x.toMap()).toList(),
    };
  }

  Message copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? content,
    DateTime? timestamp,
    String? receiverId,
    bool? isForumPost,
    List<String>? likes,
    List<Message>? replies,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      receiverId: receiverId ?? this.receiverId,
      isForumPost: isForumPost ?? this.isForumPost,
      likes: likes ?? this.likes,
      replies: replies ?? this.replies,
    );
  }
}