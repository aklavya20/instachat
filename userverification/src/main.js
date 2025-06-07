import * as sdk from "node-appwrite";

export default async function main(context) {
  const client = new sdk.Client()
    .setEndpoint(process.env.APPWRITE_ENDPOINT)
    .setProject(process.env.APPWRITE_PROJECT_ID)
    .setKey(process.env.APPWRITE_API_KEY);

  const users = new sdk.Users(client);

  try {
    const rawBody = context.req.body;

    context.log("Received body:", rawBody);

    if (!rawBody) {
      return context.res.send({
        status: "error",
        message: "Missing body in request",
      });
    }

    const { userId } = JSON.parse(rawBody);

    if (!userId) {
      return context.res.send({
        status: "error",
        message: "Missing userId in payload",
      });
    }

    const result = await users.updateEmailVerification(userId, true);

    return context.res.send({
      status: "success",
      message: `User ${userId} verified successfully.`,
      user: result,
    });
  } catch (error) {
    context.error("Function Error:", error.message);
    return context.res.send({
      status: "error",
      message: error.message,
    });
  }
}

/**
 * tar -zcvf filename.tar.gz ./* 
 * run this command in function directory to create a tar.gz file
 * .env file structure:
 * APPWRITE_ENDPOINT=
 * APPWRITE_PROJECT_ID=
 * APPWRITE_API_KEY=
*/
