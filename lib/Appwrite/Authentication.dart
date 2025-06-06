import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:instachat/Constants/Constants.dart';
import 'package:instachat/Appwrite/AppwriteService.dart';

Constants constants = Constants();

Client client = Client()
    .setEndpoint(constants.AppwriteEndpoint)
    .setProject(constants.AppwriteProjectId);

Account account = Account(client);
Functions functions = Functions(client);

// Future updateUserLabel(String userId, String role) async {
//   try {
//     final result = await functions.createExecution(
//       functionId: '67fe759000389b9ca0ec',
//       path: jsonEncode({'userId': userId, 'labels': role}),
//     );
//     print("This is Our Result:result");
//     return result.status == 'completed'
//         ? 'Label Updated'
//         : 'Failed to update label';
//   } on AppwriteException catch (e) {
//     return e.message.toString();
//   } catch (e) {
//     print('Error: $e');
//   }
// }

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
    //here
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
