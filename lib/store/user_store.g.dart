// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$_roleAtom = Atom(name: '_UserStore._role', context: context);

  @override
  String get _role {
    _$_roleAtom.reportRead();
    return super._role;
  }

  @override
  set _role(String value) {
    _$_roleAtom.reportWrite(value, super._role, () {
      super._role = value;
    });
  }

  late final _$requestsCountAtom =
      Atom(name: '_UserStore.requestsCount', context: context);

  @override
  RequestsCount? get requestsCount {
    _$requestsCountAtom.reportRead();
    return super.requestsCount;
  }

  @override
  set requestsCount(RequestsCount? value) {
    _$requestsCountAtom.reportWrite(value, super.requestsCount, () {
      super.requestsCount = value;
    });
  }

  late final _$profileAtom = Atom(name: '_UserStore.profile', context: context);

  @override
  Profile? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  late final _$_selectedIndexAtom =
      Atom(name: '_UserStore._selectedIndex', context: context);

  @override
  int get _selectedIndex {
    _$_selectedIndexAtom.reportRead();
    return super._selectedIndex;
  }

  @override
  set _selectedIndex(int value) {
    _$_selectedIndexAtom.reportWrite(value, super._selectedIndex, () {
      super._selectedIndex = value;
    });
  }

  late final _$getUserDataInfoAsyncAction =
      AsyncAction('_UserStore.getUserDataInfo', context: context);

  @override
  Future<void> getUserDataInfo() {
    return _$getUserDataInfoAsyncAction.run(() => super.getUserDataInfo());
  }

  late final _$getGuestInfoAsyncAction =
      AsyncAction('_UserStore.getGuestInfo', context: context);

  @override
  Future<void> getGuestInfo() {
    return _$getGuestInfoAsyncAction.run(() => super.getGuestInfo());
  }

  late final _$getRequestsCountAsyncAction =
      AsyncAction('_UserStore.getRequestsCount', context: context);

  @override
  Future<void> getRequestsCount() {
    return _$getRequestsCountAsyncAction.run(() => super.getRequestsCount());
  }

  late final _$requairedUserDataAsyncAction =
      AsyncAction('_UserStore.requairedUserData', context: context);

  @override
  Future<void> requairedUserData() {
    return _$requairedUserDataAsyncAction.run(() => super.requairedUserData());
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void requiredData() {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.requiredData');
    try {
      return super.requiredData();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
requestsCount: ${requestsCount},
profile: ${profile}
    ''';
  }
}
