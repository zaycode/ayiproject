import 'dart:io';

import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension extString on String? {
  bool get isNullOrEmpty =>
      this == null ||
      (this != null && this!.trim().isEmpty) ||
      (this != null && this! == 'null');

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String toCapitalized() => (this?.length ?? 0) > 0
      ? '${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}'
      : '';

  String get toTitleCase =>
      this
          ?.replaceAll(RegExp(' +'), ' ')
          .split(' ')
          .map((str) => str.toCapitalized())
          .join(' ') ??
      "";

  bool containsIgnoreCase(String? other) {
    if (other == null) return false;
    return this?.toLowerCase().contains(other.toLowerCase()) ?? false;
  }

  bool equalsIgnoreCase(String? b) => this?.toLowerCase() == b?.toLowerCase();
}

extension IterableExtensions<T> on Iterable<T>? {
  /// Returns `true` if this nullable iterable is either `null` or empty.
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  /// Returns `false` if this nullable iterable is either `null` or empty.
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }

  /// Returns `true` if at least one element matches the given [predicate].
  bool any(bool predicate(T element)) {
    if (this.isNullOrEmpty()) return false;
    for (final element in this!) if (predicate(element)) return true;
    return false;
  }

  /// Returns count of elements that matches the given [predicate].
  /// Returns -1 if iterable is null
  int countWhere(bool predicate(T element)) {
    if (this == null) return -1;
    return this!.where(predicate).length;
  }

  void forEachIndexed(void action(T element, int index)) {
    var index = 0;
    for (var element in this!) {
      action(element, index++);
    }
  }

  /// Groups elements of the original collection by the key returned by the given [keySelector] function

  Map<K, List<T>> groupBy<T, K>(K keySelector(T e)) {
    if (this == null) return {};
    var map = <K, List<T>>{};

    for (final element in this!) {
      var list = map.putIfAbsent(keySelector(element as T), () => []);
      list.add(element);
    }
    return map;
  }

  /// Returns a list containing only elements matching the given [predicate!]
  List<T> filter(bool test(T element)) {
    if (this == null) return <T>[];
    final result = <T>[];
    this!.forEach((e) {
      if (test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements not matching the given [predicate!]
  List<T> filterNot(bool test(T element)) {
    if (this == null) return <T>[];
    final result = <T>[];
    this!.forEach((e) {
      if (!test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements that are not null
  List<T> filterNotNull() {
    if (this == null) return <T>[];
    final result = <T>[];
    this!.forEach((e) {
      if (e != null) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing first [n] elements.
  List<T> take(int n) {
    if (this == null) return <T>[];
    if (n <= 0) return [];

    var list = <T>[];
    if (this is Iterable) {
      if (n >= this!.length) return this!.toList();

      var count = 0;
      var thisList = this!.toList();
      for (var item in thisList) {
        list.add(item);
        if (++count == n) break;
      }
    }
    return list;
  }

  T? get firstOrNull => this.isNullOrEmpty() ? null : this!.first;

  T? firstWhereOrNull(bool Function(T element) test) {
    if (this == null) return null;
    final list = this!.where(test);
    return list.isEmpty ? null : list.first;
  }

  List<R> mapWithIndex<R>(R Function(T, int i) callback) {
    List<R> result = [];
    for (int i = 0; i < (this?.length ?? 0); i++) {
      R item = callback(this!.toList()[i], i);
      result.add(item);
    }
    return result;
  }
}

extension FileUtils on File {
  double get size {
    int sizeInBytes = this.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}
