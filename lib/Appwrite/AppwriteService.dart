import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:instachat/Constants/Constants.dart';

Constants constants = Constants();

Client client = Client()
    .setEndpoint(constants.AppwriteEndpoint)
    .setProject(constants.AppwriteProjectId);

Account account = Account(client);

Future<User?> getUser() async {
  try {
    final user = await account.get();
    return user;
  } catch (e) {
    return null;
  }
}
