import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint(
      'https://8080-appwrite-integrationfor-r0qkffgkvqn.ws-us118.gitpod.io/v1',
    )
    .setProject('67f26b71002a16a7623d');

Account account = Account(client);

Future createUser(String username, String email, String password) async {
  try {
    await account.create(
      userId: ID.unique(),
      name: username,
      email: email,
      password: password,
    );
    return 'Success';
  } on AppwriteException catch (e) {
    return e.message.toString();
  } catch (e) {
    print('Error: $e');
  }
}

Future loginUser(String email, String password) async {
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
