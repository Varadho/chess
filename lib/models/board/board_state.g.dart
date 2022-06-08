// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardStateCWProxy {
  BoardState castlingRights(String castlingRights);

  BoardState enPassantTarget(Coordinate? enPassantTarget);

  BoardState squares(List<List<Square>> squares);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BoardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BoardState(...).copyWith(id: 12, name: "My name")
  /// ````
  BoardState call({
    String? castlingRights,
    Coordinate? enPassantTarget,
    List<List<Square>>? squares,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBoardState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBoardState.copyWith.fieldName(...)`
class _$BoardStateCWProxyImpl implements _$BoardStateCWProxy {
  final BoardState _value;

  const _$BoardStateCWProxyImpl(this._value);

  @override
  BoardState castlingRights(String castlingRights) =>
      this(castlingRights: castlingRights);

  @override
  BoardState enPassantTarget(Coordinate? enPassantTarget) =>
      this(enPassantTarget: enPassantTarget);

  @override
  BoardState squares(List<List<Square>> squares) => this(squares: squares);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BoardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BoardState(...).copyWith(id: 12, name: "My name")
  /// ````
  BoardState call({
    Object? castlingRights = const $CopyWithPlaceholder(),
    Object? enPassantTarget = const $CopyWithPlaceholder(),
    Object? squares = const $CopyWithPlaceholder(),
  }) {
    return BoardState(
      castlingRights: castlingRights == const $CopyWithPlaceholder() ||
              castlingRights == null
          ? _value.castlingRights
          // ignore: cast_nullable_to_non_nullable
          : castlingRights as String,
      enPassantTarget: enPassantTarget == const $CopyWithPlaceholder()
          ? _value.enPassantTarget
          // ignore: cast_nullable_to_non_nullable
          : enPassantTarget as Coordinate?,
      squares: squares == const $CopyWithPlaceholder() || squares == null
          ? _value.squares
          // ignore: cast_nullable_to_non_nullable
          : squares as List<List<Square>>,
    );
  }
}

extension $BoardStateCopyWith on BoardState {
  /// Returns a callable class that can be used as follows: `instanceOfBoardState.copyWith(...)` or like so:`instanceOfBoardState.copyWith.fieldName(...)`.
  _$BoardStateCWProxy get copyWith => _$BoardStateCWProxyImpl(this);
}
