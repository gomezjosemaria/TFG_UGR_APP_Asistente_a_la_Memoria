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
  final String photo;

  const UserModel(this.id, this.email, this.name, this.photo);

  @override
  List<Object?> get props => [id, email, name, photo];

  static const empty = UserModel('', '', '', '');
}
