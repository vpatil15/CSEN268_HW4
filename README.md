CSEN280 - HW4
Book App with Login (Flutter)

What the app does
-----------------
A simple book app with a login screen.

1. You start on the Login screen. Tap "Login".
2. You see a list of books "Sorted by Author".
   At the bottom there are 3 tabs: By Author, By Title, Profile.
3. Tap a book to open its detail page. Use the back arrow to return.
4. The "By Title" tab shows the list "Sorted by Title".
5. The "Profile" tab has a "Logout" button. Tap it to go back to Login.

How it works
------------
- AuthenticationBloc
  Remembers if the user is logged in or not logged in.
  It is placed above MaterialApp.router so the whole app can use it.

- GoRouter
  Gives every screen its own path:
    /                  (home)
      /byAuthor        (byAuthor)
        /detail        (byAuthorDetail)
      /byTitle         (byTitle)
        /detail        (byTitleDetail)
      /profile         (profile)
    /login             (login)
  The By Author, By Title and Profile screens are inside a ShellRoute,
  so the bottom tabs stay on screen.

- Listenable
  Listens to the AuthenticationBloc. When login state changes,
  it tells GoRouter to check the redirect again.

- Redirect
  Runs every time the path changes or the login state changes.
    Logged in and on /login       -> go to /byAuthor
    Not logged in and not on /login -> go to /login

The Login and Logout buttons only change the login state.
The redirect moves the user to the correct screen.

Project files
-------------
lib/main.dart                         Starts the app, adds the bloc
lib/bloc/authentication_bloc.dart     Login / logout logic
lib/router/app_router.dart            All routes and the redirect
lib/router/stream_listenable.dart     Turns the bloc into a Listenable
lib/screens/                          All the screens

How to run
----------
1. flutter pub get
2. flutter run
3. Pick Chrome or macOS when asked.

How to test
-----------
flutter test