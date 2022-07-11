// enum MessageType { TEXT, IMAGE, FILE }

// class MessageModel {
//   String sender;
//   String content;
//   String time;
//   String profile;

//   MessageType messageType;
//   MessageModel({
//     this.content =
//         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets conta",
//     this.sender = "Domnic lakra",
//     this.profile =
//         "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
//     this.time = "11:15 am",
//     this.messageType = MessageType.TEXT,
//   });
// }

// List<MessageModel> messages = [
//   MessageModel(
//       content: "hi",
//       sender: "Rohit",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//     // content: "hi",
//     sender: "Rohit",
//     time: "11:45",
//     // profile:
//     //     "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"
//   ),
//   MessageModel(
//       content: "How are you?",
//       sender: "kohli",
//       time: "11:50",
//       messageType: MessageType.IMAGE),
//   MessageModel(
//       content: "How are you?",
//       sender: "kohli",
//       time: "11:50",
//       messageType: MessageType.IMAGE),
//   MessageModel(
//     content: "Any content including messages, photos, videos, voice messages,",
//     sender: "Rohit",
//     time: "11:55",
//   ),
//   MessageModel(
//       content: "documents and calls ",
//       sender: "Rohit",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//     // content: "fine",
//     sender: "Rohit",
//     messageType: MessageType.FILE,
//     time: "11:55",
//   ),
//   MessageModel(
//     // content: "fine",
//     sender: "Rohit",
//     messageType: MessageType.FILE,
//     time: "11:55",
//   ),
//   MessageModel(
//       content: "how are you?",
//       sender: "Paras",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "fine what's about your",
//       sender: "Jaydip",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "how are you?",
//       sender: "Urmil",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "fine what's about your",
//       sender: "Raj",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "how are you?",
//       sender: "Alex",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "fine what's about your",
//       sender: "Gigi",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "how are you?",
//       sender: "Messi",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
//   MessageModel(
//       content: "fine what's about your",
//       sender: "Tashvir",
//       time: "11:45",
//       profile:
//           "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
// ].reversed.toList();
