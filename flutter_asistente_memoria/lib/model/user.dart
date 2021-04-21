import 'package:equatable/equatable.dart';

class UserModel extends Equatable {

  final String id;
  final String email;
  final String name;
  final String photo;
  final bool caregiver;

  const UserModel(this.id, this.email, this.name, this.photo, this.caregiver);

  @override
  List<Object?> get props => [id, email, name, photo, caregiver];

  static const empty = UserModel('', '', '', '', false);
}