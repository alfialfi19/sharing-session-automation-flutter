import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sharing_session/commons/commons.dart';
import 'package:sharing_session/main_delegate.dart';
import 'package:sharing_session/my_app.dart';
import 'package:sharing_session/screens/screens.dart';

import '../../test/mock/mock.dart';

void main() {
  // final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Clients
  final MockBaseDioClient dioClient = MockBaseDioClient();

  /// Api
  final MockCommentsApi commentsApi = MockCommentsApi();
  final MockPostsApi postsApi = MockPostsApi();
  final MockUsersApi usersApi = MockUsersApi();

  /// Repositories
  final MockCommentRepository commentRepo = MockCommentRepository();
  final MockPostRepository postRepo = MockPostRepository();
  final MockUserRepository userRepo = MockUserRepository();

  Future<void> pumpAppWithMockDependency(WidgetTester tester) async {
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

  group('sign_in_test.dart', () {
    group('Given: Failed Test Flow', () {
      testWidgets(
          'When: User sign in - Then: failed sign in and'
          ' show toast error', (WidgetTester tester) async {
        await pumpAppWithMockDependency(tester);
        await tester.pumpAndSettle();

        // // Splash Screen loaded
        // expect(find.byType(SplashScreen), findsOneWidget);

        // // Necessary delay for integration testing
        // await Future.delayed(const Duration(seconds: 2));
        //
        // Sign In Screen loaded
        await expectLater(find.byType(SignInScreen), findsOneWidget);

        // Fill email
        await tester.enterText(
          find.byKey(const Key(UIKeys.signInFormFieldEmail)),
          '',
        );
        await tester.pump(const Duration(milliseconds: 250));

        // Fill pass
        await tester.enterText(
          find.byKey(const Key(UIKeys.signInFormFieldPassword)),
          '',
        );
        await tester.pump(const Duration(milliseconds: 250));

        // Stub sign in process
        // no need for this case, because only dummy process

        // Tap sign in button
        await tester.tap(
          find.byKey(
            const Key(UIKeys.signInActionButton),
          ),
        );
        await tester.pumpAndSettle();

        await tester.pump(const Duration(seconds: 3));
      });
    });

    group('Given: Normal Test Flow', () {
      testWidgets(
          'When: User sign in - Then: Successfully sign in and'
          ' redirect to Main Screen', (WidgetTester tester) async {
        await pumpAppWithMockDependency(tester);
        await tester.pumpAndSettle();

        // // Splash Screen loaded
        // expect(find.byType(SplashScreen), findsOneWidget);

        // // Necessary delay for integration testing
        // await Future.delayed(const Duration(seconds: 3));

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

        // Stub sign in process
        // no need for this case, because only dummy process

        // Tap sign in button
        await tester.tap(
          find.byKey(
            const Key(UIKeys.signInActionButton),
          ),
        );
        await tester.pumpAndSettle();

        // Main Screen loaded
        await expectLater(find.byType(MainScreen), findsOneWidget);
        await tester.pump(const Duration(seconds: 3));

        // // Stub get posts data
        // when(postRepo.getListPosts()).thenAnswer((_) => Future.value(
        //       mockPostsList,
        //     ));
      });
    });
  });
}
