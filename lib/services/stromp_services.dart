import 'dart:convert';
import 'dart:developer';

import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/model/comment_model.dart';
import 'package:live_tv/model/notification_model.dart';
import 'package:live_tv/model/reaction_model.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class StompServices {
  StompClient? _stompClient;

  StompClient get client => _stompClient!;

  static final StompServices instance = StompServices._initial();

  StompServices._initial() {
    _stompClient = StompClient(
      config: StompConfig(
        url: Configuration.stompHost,
        connectionTimeout: Duration(milliseconds: 3000),
        stompConnectHeaders: {},
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onConnect: _onConnect,
        onDisconnect: _onDisconnect,
      ),
    );
  }
  void subscribeComment(int id, Function(CommentModel) callBack) {
    client.subscribe(
        destination: '/topic/livestreams/$id/comments',
        callback: (frame) {
          log('commentSubscribe');
          log('commentSubscribe-frame: ${frame.body}');
          final result = json.decode(frame.body ?? '') as Map<String, dynamic>;
          callBack(CommentModel.fromJson(result));
        });
  }

  void subscribeViewCount(int id, Function(int) callBack) {
    client.subscribe(
        destination: '/topic/livestreams/$id/views-count',
        callback: (frame) {
          log('viewCountSubscribe');
          log('viewCountSubscribe-frame: ${frame.body}');
          final result = json.decode(frame.body!);
          callBack(result['viewsCount']);
        });
  }

  void subscribeReaction(int id, Function(ReactionModel) callBack) {
    client.subscribe(
        destination: '/topic/livestreams/$id/reactions',
        callback: (frame) {
          log('reactionSubscribe');
          log('reactionSubscribe-frame: ${frame.body}');
          final result = json.decode(frame.body!);
          callBack(ReactionModel.fromJson(result));
        });
  }

  void subscribeStreamEnd(int id, Function(int) callBack) {
    client.subscribe(
        destination: '/topic/livestreams/$id/end',
        callback: (frame) {
          log('streamEndSubscribe');
          log('streamEndSubscribe-frame: ${frame.body}');
          callBack(0);
        });
  }

  void subscribeNotification(int id, Function(NotificationModel) callBack) {
    client.subscribe(
        destination: '/topic/users/$id/notifications',
        callback: (frame) {
          log('notificationSubscribe');
          log('notificationSubscribe-frame: ${frame.body}');
          final result = json.decode(frame.body!);
          callBack(NotificationModel.fromJson(result));
        });
  }
}

void _onConnect(StompFrame frame) {}
void _onDisconnect(StompFrame frame) {}
