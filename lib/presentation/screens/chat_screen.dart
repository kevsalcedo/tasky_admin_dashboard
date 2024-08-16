import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/config/constants/environment.dart';

class ChatScreen extends StatefulWidget {
  static const String name = chatScreen;

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _openAI = OpenAI.instance.build(
    token: Environment.openaAIKey,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );

  final ChatUser _admin = ChatUser(
    id: '1',
    firstName: 'Sebastian',
    lastName: 'Martinez',
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Chat',
    lastName: 'GPT',
  );

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text(
          'User name',
          style: TextStyle(color: colors.onSecondary),
        ),
      ),
      body: DashChat(
        currentUser: _admin,
        typingUsers: _typingUsers,
        messageOptions: MessageOptions(
            currentUserContainerColor: colors.primary,
            containerColor: Colors.white54,
            textColor: colors.primary,
            currentUserTextColor: Colors.white),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {

    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    /* List<Map<String, dynamic>> messagesHistory =
        _messages.reversed.toList().map((m) {
      if (m.user == _admin) {
        return Messages(role: Role.user, content: m.text).toJson();
      } else {
        return Messages(role: Role.assistant, content: m.text).toJson();
      }
    }).toList(); */

    List<Messages> messagesHistory =
        _messages.reversed.map((m) {
      if (m.user == _admin) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();


    final request = ChatCompleteText(
      //model: GptTurbo0301ChatModel(),
      model: GptTurboChatModel(),
      //model: Gpt4oMini2024ChatModel(),
      messages: messagesHistory,
      maxToken: 200,
    );

    //TODO: solve error
    final response = await _openAI.onChatCompletion(request: request);

    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser,
              createdAt: DateTime.now(),
              text: element.message!.content,
            ),
          );
        });
      }
    }

   /* final request = Assistant(
    model: Gpt4AModel(),
    name: 'Math Tutor',
    instructions:
    'You are a personal math tutor. When asked a question, write and run Python code to answer the question.',
    tools: [
      {
        "type": "code_interpreter",
      }
    ],
  );

    final response = await _openAI.assistant.create(assistant: request);

    for (var element in response.tools) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser,
              createdAt: DateTime.now(),
              text: element.message!.content,
            ),
          );
        });
      }
    } */
    
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}



/* import 'package:flutter/material.dart';

import 'package:tasky_admin_dashboard/presentation/widgets/chat/chat_message.dart';
import 'package:tasky_admin_dashboard/presentation/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isWritting = false;

  List<ChatMessage> _messages = [];
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: colors.primary,
                child: Text(
                  'userFor.name.substring(0, 2)',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'userFor.name',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          backgroundColor: Colors.cyan[400],
          elevation: 1,
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemBuilder: (_, index) => _messages[index],
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                ),
              ),
              const Divider(height: 1),
              
            ],
          ),
        ));
  }
}
 */