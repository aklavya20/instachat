import 'dart:convert' show jsonEncode;

import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint(
      'https://8080-appwrite-integrationfor-r0qkffgkvqn.ws-us118.gitpod.io/v1',
    )
    .setProject('67f26b71002a16a7623d');

Account account = Account(client);
Functions functions = Functions(client);

Future updateUserLabel(String userId, String role) async {
  try {
    final result = await functions.createExecution(
      functionId: '67fe759000389b9ca0ec',
      path: jsonEncode({'userId': userId, 'role': role}),
    );
    return result.status == 'completed'
        ? 'Label Updated'
        : 'Failed to update label';
  } on AppwriteException catch (e) {
    return e.message.toString();
  } catch (e) {
    print('Error: $e');
  }
}

Future createUser(
  String username,
  String email,
  String password,
  String role,
) async {
  String userId = ID.unique();
  try {
    await account.create(
      userId: userId,
      name: username,
      email: email,
      password: password,
    );
    await updateUserLabel(userId, role);
    return 'Success';
  } on AppwriteException catch (e) {
    return e.message.toString();
  } catch (e) {
    print('Error: $e');
  }
}

Future loginUser(String email, String password, String role) async {
  try {
    await account.createEmailPasswordSession(email: email, password: password);
    return 'Success';
  } on AppwriteException catch (e) {
    return e.message.toString();
  } catch (e) {
    print('Error: $e');
  }
}

Future checkUserSession() async {
  try {
    await account.getSession(sessionId: "current");
    return true;
  } catch (e) {
    return false;
  }
}

Future logoutUser() async {
  await account.deleteSession(sessionId: "current");
}
