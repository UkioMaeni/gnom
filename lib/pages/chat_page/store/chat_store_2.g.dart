// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store_2.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore2 on _ChatStore2, Store {
  late final _$chatsAtom = Atom(name: '_ChatStore2.chats', context: context);

  @override
  ObservableMap<String, ChatInfo> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableMap<String, ChatInfo> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$_ChatStore2ActionController =
      ActionController(name: '_ChatStore2', context: context);

  @override
  dynamic addMessage(MessInterface<dynamic> mess, BuildContext context) {
    final _$actionInfo = _$_ChatStore2ActionController.startAction(
        name: '_ChatStore2.addMessage');
    try {
      return super.addMessage(mess, context);
    } finally {
      _$_ChatStore2ActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chats: ${chats}
    ''';
  }
}
