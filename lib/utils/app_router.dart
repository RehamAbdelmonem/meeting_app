





// abstract class AppRouter{
// static const kHomeView = '/homeView';
//   static const kBookDetailsView = '/bookDetailsView';
//   static const kSearchView = '/searchView';
//   static const kSearchResult = '/searchResult';
//   static final router = GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const SplashView(),
//       ),
//       GoRoute(
//         path: kHomeView,
//         builder: (context, state) => const HomeView(),
//       ),
//       GoRoute(
//         path: kBookDetailsView,
//         builder: (context, state) => BlocProvider(
//           create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
//           child: BookDetailsView(
//             bookModel: state.extra as BookModel,
//           ),
//         ),
//       ),
//       GoRoute(
//         path: kSearchView,
//         builder: (context, state) =>  BlocProvider(
//           create: (context) => SearchedBooksCubit(getIt.get<SearchRepoImpl>()),
//           child: const SearchView(),
//         ),
//       ),
//       GoRoute(
//         path: kSearchResult,
//         builder: (context, state) =>  BlocProvider(
//           create: (context) => SearchedBooksCubit(getIt.get<SearchRepoImpl>()),
//           child: const SearchResultListView(),
//         ),
//       ),
//     ],
//   );
// }
