// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_support_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  late final _$chatsAtom = Atom(name: '_ChatStore.chats', context: context);

  @override
  ObservableList<Message> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<Message> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$addMessageAsyncAction =
      AsyncAction('_ChatStore.addMessage', context: context);

  @override
  Future addMessage(String message, XFile? file) {
    return _$addMessageAsyncAction.run(() => super.addMessage(message, file));
  }

  @override
  String toString() {
    return '''
chats: ${chats}
    ''';
  }
}
