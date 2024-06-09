import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'role_provider.g.dart';

@Riverpod(keepAlive: true)
class RoleState extends _$RoleState {
  @override
  Role? build() {
    return null;
  }

  void setRole(String? role) async {
    switch (role) {
      case 'ADMIN':
        state = Role.admin;
        break;
      case 'COMPANY':
        state = Role.company;
        break;
      case 'SALESRESPONSIBLE':
        state = Role.salesResponsible;
        break;
      case 'WAREHOUSEPERSON':
        state = Role.warehouseperson;
        break;
      case 'CONTROLLER':
        state = Role.controller;
        break;
      default:
        state = Role.company;
    }
  }
}

enum Role { company, salesResponsible, warehouseperson, controller, admin }
