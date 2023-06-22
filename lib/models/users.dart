import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class Users extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  const Users({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        address,
        phone,
      ];
}

@JsonSerializable()
class Address extends Equatable {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
  });

  @override
  List<Object?> get props => [
        street,
        suite,
        city,
        zipcode,
      ];
}
