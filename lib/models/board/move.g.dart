// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MoveCWProxy {
  Move start(Coordinate start);

  Move target(Coordinate target);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Move(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Move(...).copyWith(id: 12, name: "My name")
  /// ````
  Move call({
    Coordinate? start,
    Coordinate? target,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMove.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMove.copyWith.fieldName(...)`
class _$MoveCWProxyImpl implements _$MoveCWProxy {
  final Move _value;

  const _$MoveCWProxyImpl(this._value);

  @override
  Move start(Coordinate start) => this(start: start);

  @override
  Move target(Coordinate target) => this(target: target);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Move(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Move(...).copyWith(id: 12, name: "My name")
  /// ````
  Move call({
    Object? start = const $CopyWithPlaceholder(),
    Object? target = const $CopyWithPlaceholder(),
  }) {
    return Move(
      start: start == const $CopyWithPlaceholder() || start == null
          ? _value.start
          // ignore: cast_nullable_to_non_nullable
          : start as Coordinate,
      target: target == const $CopyWithPlaceholder() || target == null
          ? _value.target
          // ignore: cast_nullable_to_non_nullable
          : target as Coordinate,
    );
  }
}

extension $MoveCopyWith on Move {
  /// Returns a callable class that can be used as follows: `instanceOfMove.copyWith(...)` or like so:`instanceOfMove.copyWith.fieldName(...)`.
  _$MoveCWProxy get copyWith => _$MoveCWProxyImpl(this);
}

abstract class _$TurnCWProxy {
  Turn blacksMove(Move? blacksMove);

  Turn whitesMove(Move whitesMove);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Turn(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Turn(...).copyWith(id: 12, name: "My name")
  /// ````
  Turn call({
    Move? blacksMove,
    Move? whitesMove,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTurn.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTurn.copyWith.fieldName(...)`
class _$TurnCWProxyImpl implements _$TurnCWProxy {
  final Turn _value;

  const _$TurnCWProxyImpl(this._value);

  @override
  Turn blacksMove(Move? blacksMove) => this(blacksMove: blacksMove);

  @override
  Turn whitesMove(Move whitesMove) => this(whitesMove: whitesMove);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Turn(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Turn(...).copyWith(id: 12, name: "My name")
  /// ````
  Turn call({
    Object? blacksMove = const $CopyWithPlaceholder(),
    Object? whitesMove = const $CopyWithPlaceholder(),
  }) {
    return Turn(
      blacksMove: blacksMove == const $CopyWithPlaceholder()
          ? _value.blacksMove
          // ignore: cast_nullable_to_non_nullable
          : blacksMove as Move?,
      whitesMove:
          whitesMove == const $CopyWithPlaceholder() || whitesMove == null
              ? _value.whitesMove
              // ignore: cast_nullable_to_non_nullable
              : whitesMove as Move,
    );
  }
}

extension $TurnCopyWith on Turn {
  /// Returns a callable class that can be used as follows: `instanceOfTurn.copyWith(...)` or like so:`instanceOfTurn.copyWith.fieldName(...)`.
  _$TurnCWProxy get copyWith => _$TurnCWProxyImpl(this);
}
