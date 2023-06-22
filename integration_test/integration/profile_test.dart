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
  ];

  Address mockAddressData = const Address(
    street: "Kulas Light",
    suite: "Apt. 556",
    city: "San Francisco",
    zipcode: "92998-3874",
  );

  Users mockUserData = Users(
    id: 1,
    name: "Stephen Curry",
    username: "stephcurry30",
    email: "stephen.curry@mekari.com",
    address: mockAddressData,
    phone: "14022",
  );

  group('profile_test.dart', () {
    group('Given: Error Test Flow', () {
      testWidgets(
          'When: User sign in - Then: Successfully sign in and'
          ' redirect to Home Screen - Then: Success get List Data and'
          ' redirect to Product Screen - Then: Success get List Data and'
          ' redirect to Profile Screen - Then: Failed get Data',
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

        // Stub get product data
        when(postRepo.getListPosts()).thenAnswer((_) => Future.value(
              mockPostsList,
            ));

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

        // Stub get user data
        when(userRepo.getUsers()).thenThrow(Error);

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
          find.byKey(const Key(UIKeys.profileContentErrorSection)),
          findsOneWidget,
        );

        await tester.pump(const Duration(seconds: 3));
      });
    });

    group('Given: Normal Test Flow', () {
      testWidgets(
          'When: User sign in - Then: Successfully sign in and'
          ' redirect to Home Screen - Then: Success get List Data and'
          ' redirect to Product Screen - Then: Success get List Data and'
          ' redirect to Profile Screen - Then: Success get Data',
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

        // Stub get product data
        when(postRepo.getListPosts()).thenAnswer((_) => Future.value(
              mockPostsList,
            ));

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

        // Stub get user data
        when(userRepo.getUsers()).thenAnswer(
          (_) => Future.value(mockUserData),
        );

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
  });
}
