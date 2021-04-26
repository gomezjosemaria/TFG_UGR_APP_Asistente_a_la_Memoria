import 'package:equatable/equatable.dart';

enum UserRole {caregiver, careReceiver, unselected}

class UserModel extends Equatable {

  final String id;
  final String email;
  final String name;
  final String photo;
  final UserRole role;

  const UserModel(this.id, this.email, this.name, this.photo, this.role);

  @override
  List<Object?> get props => [id, email, name, photo, role];

  static const empty = UserModel('', '', '', '', UserRole.unselected);
}