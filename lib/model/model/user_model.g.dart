// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserModelCWProxy {
  UserModel bio(String? bio);

  UserModel id(String? id);

  UserModel username(String? username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserModel call({
    String? bio,
    String? id,
    String? username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserModel.copyWith.fieldName(...)`
class _$UserModelCWProxyImpl implements _$UserModelCWProxy {
  final UserModel _value;

  const _$UserModelCWProxyImpl(this._value);

  @override
  UserModel bio(String? bio) => this(bio: bio);

  @override
  UserModel id(String? id) => this(id: id);

  @override
  UserModel username(String? username) => this(username: username);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserModel call({
    Object? bio = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return UserModel(
      bio: bio == const $CopyWithPlaceholder()
          ? _value.bio
          // ignore: cast_nullable_to_non_nullable
          : bio as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String?,
    );
  }
}

extension $UserModelCopyWith on UserModel {
  /// Returns a callable class that can be used as follows: `instanceOfUserModel.copyWith(...)` or like so:`instanceOfUserModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserModelCWProxy get copyWith => _$UserModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'bio': instance.bio,
    };
