import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sharing_session/api/api.dart';
import 'package:sharing_session/commons/commons.dart';
import 'package:sharing_session/main_delegate.dart';
import 'package:sharing_session/my_app.dart';
import 'package:sharing_session/repositories/repositories.dart';
import 'package:sharing_session/screens/screens.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Clients
  final BaseDioClient dioClient = BaseDioClient();

  final CommentsApi commentsApi = CommentsApi(dioClient.dio);
  final PostsApi postsApi = PostsApi(dioClient.dio);
  final UsersApi usersApi = UsersApi(dioClient.dio);

  /// Repository
  final CommentRepository commentRepo = CommentRepository(commentsApi);
  final PostRepository postRepo = PostRepository(postsApi);
  final UserRepository userRepo = UserRepository(usersApi);

  Future<void> pumpAppWithDependency(WidgetTester tester) async {
    await mainDelegate();

    await tester.pumpWidget(
      MyApp(
        dioClient: dioClient,
        commentsApi: commentsApi,
        postsApi: postsApi,
        usersApi: usersApi,
        commentRepository: commentRepo,
        postRepository: postRepo,
        userRepository: userRepo,
      ),
    );
  }

  group('sign_in_until_profile_test.dart', () {
    testWidgets(
        'When: Use sign in - Then: Successfully sign in and'
        ' redirect to Home Screen and redirect to Product Screen and redirect'
        ' to Profile Screen', (WidgetTester tester) async {
      await pumpAppWithDependency(tester);
      await tester.pumpAndSettle();

      // Sign In Screen loaded
      await expectLater(find.byType(SignInScreen), findsOneWidget);

      // Fill email
      await tester.enterText(
        find.byKey(const Key(UIKeys.signInFormFieldEmail)),
        'test@test.com',
      );
      await tester.pump(const Duration(milliseconds: 250));

      // Fill pass
      await tester.enterText(
        find.byKey(const Key(UIKeys.signInFormFieldPassword)),
        'abc123',
      );
      await tester.pump(const Duration(milliseconds: 250));

      // Tap sign in button
      await tester.tap(
        find.byKey(
          const Key(UIKeys.signInActionButton),
        ),
      );
      await tester.pumpAndSettle();

      // Main Screen loaded
      await expectLater(find.byType(MainScreen), findsOneWidget);

      // Home Screen
      await expectLater(find.byType(HomeScreen), findsOneWidget);

      // Expect Loaded
      await expectLater(
        find.byKey(const Key(UIKeys.homeWelcomeSection)),
        findsOneWidget,
      );

      await expectLater(
        find.byKey(const Key(UIKeys.homeContentLoadedSection)),
        findsOneWidget,
      );

      await tester.pump(const Duration(seconds: 3));

      // Tap product navbar
      await tester.tap(
        find.byKey(
          const Key(UIKeys.discoverProductTabActive),
        ),
      );
      await tester.pumpAndSettle();

      // Product Screen
      await expectLater(find.byType(ProductScreen), findsOneWidget);

      // Expect Loaded
      await expectLater(
        find.byKey(const Key(UIKeys.productContentLoadedSection)),
        findsOneWidget,
      );

      await tester.pump(const Duration(seconds: 3));

      // Tap profile navbar
      await tester.tap(
        find.byKey(
          const Key(UIKeys.discoverProfileTabActive),
        ),
      );
      await tester.pumpAndSettle();

      // Product Screen
      await expectLater(find.byType(ProfileScreen), findsOneWidget);

      // Expect Loaded
      await expectLater(
        find.byKey(const Key(UIKeys.profileContentLoadedSection)),
        findsOneWidget,
      );

      await tester.pump(const Duration(seconds: 3));
    });
  });
}
