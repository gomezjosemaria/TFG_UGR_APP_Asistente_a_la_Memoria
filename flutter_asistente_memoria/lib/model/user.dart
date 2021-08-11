import 'package:equatable/equatable.dart';

enum UserRole { caregiver, careReceiver, unselected }

String userRoleToString(UserRole role) {
  String sRole = 'unselected';
  if (role == UserRole.caregiver) {
    sRole = 'caregiver';
  } else if (role == UserRole.careReceiver) {
    sRole = 'careReceiver';
  }
  return sRole;
}

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserModel(this.id, this.email, this.name);

  @override
  List<Object?> get props => [id, email, name];

  static const empty = UserModel('', '', '');
}
