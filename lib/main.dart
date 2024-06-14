import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes_no_app/config/theme/app_theme.dart';
import 'package:tes_no_app/presentation/pages/home_page.dart';
import 'package:tes_no_app/presentation/providers/chat_provider.dart';
import 'package:tes_no_app/presentation/screens/chat/chat_screen.dart';

import 'presentation/pages/404_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'Yes No App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 1).theme(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage()
        },
        onGenerateRoute: (settings) {
          final uri = Uri.parse(settings.name ?? '/');
          final pathSegments = uri.pathSegments;

          if (pathSegments.isNotEmpty) {
            switch (pathSegments[0]) {
              case 'chat':
                if (pathSegments.length > 1) {
                  final chatId = int.parse(pathSegments[1]);

                  return MaterialPageRoute(
                    builder: (context) => ChatScreen(chatId: chatId),
                  );
                } else {
                  return MaterialPageRoute(
                    builder: (context) => const Page404(),
                  );
                }
              default:
                return MaterialPageRoute(
                  builder: (context) => const Page404(),
                );
            }
          }

          return MaterialPageRoute(
            builder: (context) => const Page404(),
          );
        },
      ),
    );
  }
}