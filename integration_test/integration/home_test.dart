import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharing_session/commons/commons.dart';
import 'package:sharing_session/main_delegate.dart';
import 'package:sharing_session/models/models.dart';
import 'package:sharing_session/my_app.dart';
import 'package:sharing_session/screens/screens.dart';

import '../../test/mock/mock.dart';

void main() {
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

  Posts mockPostData = const Posts(
    id: 1,
    userId: 1,
    title: "Lorem ipsum",
    body: "Lorem ipsum til amet",
  );

  List<Posts> mockPostsList = [
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
    mockPostData,
  ];

  group('home_test.dart', () {
    group('Given: Error Test Flow', () {
      testWidgets(
          'When: User sign in - Then: Successfully sign in and'
          ' redirect to Home Screen - Then: Error get List Data',
          (WidgetTester tester) async {
        await pumpAppWithMockDependency(tester);
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

        // Stub sign in process
        // no need for this case, because only dummy process

        // Stub get posts data
        when(postRepo.getListPosts()).thenThrow(Error);

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

        // Expect Error
        await expectLater(
          find.byKey(const Key(UIKeys.homeContentErrorSection)),
          findsOneWidget,
        );

        await tester.pump(const Duration(seconds: 3));
      });
    });

    group('Given: Normal Test Flow', () {
      testWidgets(
          'When: User sign in - Then: Successfully sign in and'
          ' redirect to Home Screen - Then: Success get List Data',
          (WidgetTester tester) async {
        await pumpAppWithMockDependency(tester);
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

        // Stub sign in process
        // no need for this case, because only dummy process

        // Stub get posts data
        when(postRepo.getListPosts()).thenAnswer((_) => Future.value(
              mockPostsList,
            ));

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
      });

      testWidgets(
          'When: User sign in - Then: Successfully sign in and'
          ' redirect to Home Screen - Then: Success get List Data and'
          ' scroll down Home Screen - Then: Redirect to Detail Posts Screen',
          (WidgetTester tester) async {
        await pumpAppWithMockDependency(tester);
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

        // Stub sign in process
        // no need for this case, because only dummy process

        // Stub get posts data
        when(postRepo.getListPosts()).thenAnswer((_) => Future.value(
              mockPostsList,
            ));

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

        await tester.pump(const Duration(seconds: 2));

        // Scroll down
        await tester.dragUntilVisible(
          find.byKey(Key(UIKeys.postsItem(7))),
          find.byKey(const Key(UIKeys.homeContentLoadedSection)),
          const Offset(-500, 0),
        );
        // final gesture = await tester.startGesture(
        //   const Offset(300, 300),
        // );
        // await gesture.moveBy(
        //   const Offset(100, 100),
        // );
        // await tester.scrollUntilVisible(
        //   find.byKey(
        //     Key(UIKeys.postsItem(5)),
        //   ),
        //   200.0,
        //   // scrollable: find.byKey(
        //   //   const Key(UIKeys.homeContentLoadedSection),
        //   // ),
        //   scrollable: find.byType(Scrollable),
        // );
        // // await gesture.down(downLocation)
        //
        await tester.pumpAndSettle();

        // Tap data
        await tester.tap(
          find.byKey(
            Key(UIKeys.postsItem(7)),
          ),
        );
        await tester.pumpAndSettle();

        // Detail Posts Screen
        await expectLater(find.byType(DetailPostsScreen), findsOneWidget);

        // Expect Loaded
        await expectLater(
          find.byKey(const Key(UIKeys.discoverDetailPostsScreen)),
          findsOneWidget,
        );

        await tester.pump(const Duration(seconds: 3));
      });
    });
  });
}
