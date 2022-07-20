const functions = require("firebase-functions");
const admin = require("firebase-admin");

const parse = require("../parse");

admin.initializeApp();

exports.lmno_callback_url = functions.https.onRequest(async (req, res) => {
  const callbackData = req.body.Body.stkCallback;
  const parsedData = parse(callbackData);

  let uid = req.query.uid.split("/")[0];
  let amount = req.query.uid.split("/")[1];
  let providerUid = req.query.uid.split("/")[2];

  let transaction = admin
    .firestore()
    .collection("mpesa")
    .doc("transaction")
    .collection(uid)
    .doc("/" + parsedData.checkoutRequestID + "/");
  let wallet = admin
    .firestore()
    .collection("providers")
    .doc(providerUid)
    .collection("account")
    .doc("analytics");

  console.log("TYPE OF AMOUNT: " + typeof parsedData.amount);
  if ((await transaction.get()).exists) {
  } else {
    if (typeof parsedData.amount === typeof 1) {
      let balance = await wallet.get().then((value) => value.data().balance);
      await wallet.update({
        balance: parsedData.amount + balance,
      });
      console.log(parsedData.amount);
    }
  }

  await admin
    .firestore()
    .collection("mpesa")
    .doc("all")
    .collection("users")
    .doc()
    .set({
      amount: amount,
      type: "deposit",
      userId: uid,
      phoneNumber: parsedData.phoneNumber,
      date: parsedData.transactionDate,
    });

  if ((await transaction.get()).exists) {
    await transaction.update(parsedData);
  } else {
    await transaction.set(parsedData);
  }

  res.status(200).send("OK");
});

exports.notifocations = functions.firestore
  .document("userData/{userId}/notifications/{notification}")
  .onCreate(async (snap, context) => {
    console.log("----------------start function--------------------");

    const doc = snap.data();
    console.log(doc);
    const message = doc.message;
    const uid = context.params.userId;

    admin
      .firestore()
      .collection("users")
      .where("userId", "==", uid)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          console.log(`Found user to: ${userTo.data().fullName}`);

          // Get info user from (sent)

          const payload = {
            notification: {
              id: doc.id,
              title: doc.type + " Notification",
              body: message,
              badge: "1",
              sound: "default",
            },
            data: {
              profilePic: userTo.data().profilePic,
            },
          };
          // Let push to the target device
          admin
            .messaging()
            .sendToDevice(userTo.data().pushToken, payload)
            .then((response) => {
              console.log("Successfully sent message:", response);
            })
            .catch((error) => {
              console.log("Error sending message:", error);
            });
        });
      });

    return null;
  });

exports.sendNotification = functions.firestore
  .document("chats/{chatRoom}/messages/{message}")
  .onCreate(async (snap, context) => {
    console.log("----------------start function--------------------");

    const doc = snap.data();
    console.log(doc);

    const idFrom = doc.sender;
    const idTo = doc.to;
    const contentMessage = doc.message;

    // Get push token user to (receive)
    admin
      .firestore()
      .collection("users")
      .where("userId", "==", idTo)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((userTo) => {
          console.log(`Found user to: ${userTo.data().fullName}`);

          // Get info user from (sent)
          admin
            .firestore()
            .collection("users")
            .where("userId", "==", idFrom)
            .get()
            .then((querySnapshot2) => {
              querySnapshot2.forEach((userFrom) => {
                console.log(`${userFrom.data().fullName}`);
                const payload = {
                  notification: {
                    id: "/chat-screen",
                    title: `${userFrom.data().fullName}`,
                    body: contentMessage,
                    badge: "1",
                    sound: "default",
                  },
                  data: {
                    profilePic: userFrom.data().profilePic,
                  },
                };
                // Let push to the target device
                admin
                  .messaging()
                  .sendToDevice(userTo.data().pushToken, payload)
                  .then((response) => {
                    console.log("Successfully sent message:", response);
                  })
                  .catch((error) => {
                    console.log("Error sending message:", error);
                  });
              });
            });
        });
      });
    return null;
  });
