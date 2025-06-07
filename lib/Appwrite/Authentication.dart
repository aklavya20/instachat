import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:instachat/Constants/Constants.dart';
import 'package:instachat/Appwrite/AppwriteService.dart';
import 'dart:convert';

Constants constants = Constants();

Client client = Client()
    .setEndpoint(constants.AppwriteEndpoint)
    .setProject(constants.AppwriteProjectId);

Account account = Account(client);
Functions functions = Functions(client);

Future createUser(
  String username,
  String email,
  String password,
  String role,
) async {
  String userId = ID.unique();
  try {
    print(
      "Logs: User: $username, Email: $email, Password: $password, Role: $role",
    );
    await account.create(
      userId: userId,
      name: username,
      email: email,
      password: password,
    );
    final result = await functions.createExecution(
      functionId: constants.AppwriteFunctionId,
      body: jsonEncode({'userId': userId, 'role': role}),
    );
    print('Function execution result: ${result.responseBody}');
    return 'Success';
  } on AppwriteException catch (e) {
    return e.message.toString();
  } catch (e) {
    print('Error: $e');
  }
}

Future<String> loginUser(String email, String password, String role) async {
  try {
    await account.createEmailPasswordSession(email: email, password: password);
    User? user = await getUser();

    if (user!.emailVerification) {
      return 'Success';
    } else {
      return 'Unverified';
    }
  } on AppwriteException catch (e) {
    return e.message.toString();
  } catch (e) {
    print('Error: $e');
    return 'An unknown error occurred.';
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
