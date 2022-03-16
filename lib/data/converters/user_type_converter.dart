import '../../core/enums/user_type.dart';

String typeToString(UserType userType) {
  if (userType == UserType.user) {
    return "user";
  }
  if (userType == UserType.driver) {
    return "driver";
  }

  return "ticketChecker";
}

UserType stringToType(String typeString) {
  if (typeString == "user") {
    return UserType.user;
  }
  if (typeString == "driver") {
    return UserType.user;
  }
  return UserType.ticketChecker;
}
