import 'package:go_router/go_router.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/presentation/screens/chat_screen.dart';
import 'package:tasky_admin_dashboard/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: homeScreenPath,
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

        return HomeScreen(pageIndex: pageIndex);
      },
    ),
    GoRoute(
      path: chatPath,
      name: ChatScreen.name,
      builder: (context, state) => const ChatScreen(),
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => defaultPath,
    ),
  ],
);
