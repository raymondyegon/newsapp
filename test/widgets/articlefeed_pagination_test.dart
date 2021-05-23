import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newsapp/src/model/article_model.dart';
import '../utils/paging_controller_utils.dart';
import '../utils/screen_size_utils.dart';

double get _itemHeight => screenSize.height / pageSize;

void main() {
  testWidgets(
    'Test that pagination happens with our articles feeds',
    (WidgetTester tester) async {
      final controllerLoadedWithFirstPage =
          buildPagingControllerWithPopulatedState(
        PopulatedStateOption.ongoingWithOnePage,
      );

      tester.applyPreferredTestScreenSize();

      await _pumpPagedListView(
        tester: tester,
        pagingController: controllerLoadedWithFirstPage,
        separatorBuilder: (_, __) => const Divider(
          height: 1,
        ),
      );

      final separatorFinder = find.byType(Divider);
      expect(separatorFinder, findsNWidgets(pageSize - 1));
    },
  );

  testWidgets(
    'Test with zero data',
    (WidgetTester tester) async {
      final controllerLoadedWithNoitems =
          buildPagingControllerWithPopulatedState(
        PopulatedStateOption.noItemsFound,
      );

      tester.applyPreferredTestScreenSize();

      await _pumpPagedListView(
        tester: tester,
        pagingController: controllerLoadedWithNoitems,
        separatorBuilder: (_, __) => const SizedBox(
          height: 1,
        ),
      );

      final zeroDataFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Text && widget.data.startsWith('No Items to display'),
      );
      expect(zeroDataFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Test incase there is an error',
    (WidgetTester tester) async {
      final controllerLoadedWithError = buildPagingControllerWithPopulatedState(
        PopulatedStateOption.errorOnFirstPage,
      );

      tester.applyPreferredTestScreenSize();

      await _pumpPagedListView(
        tester: tester,
        pagingController: controllerLoadedWithError,
        separatorBuilder: (_, __) => const SizedBox(
          height: 1,
        ),
      );

      final errorFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Text && widget.data.startsWith('An error occured'),
      );

      expect(errorFinder, findsOneWidget);
    },
  );
}

Future<void> _pumpPagedListView({
  @required WidgetTester tester,
  @required PagingController<int, ArticleModel> pagingController,
  IndexedWidgetBuilder separatorBuilder,
}) =>
    tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: separatorBuilder == null
              ? PagedListView(
                  pagingController: pagingController,
                  physics: BouncingScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<ArticleModel>(
                    itemBuilder: _buildItem,
                  ),
                )
              : PagedListView.separated(
                  pagingController: pagingController,
                  physics: BouncingScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<ArticleModel>(
                    itemBuilder: _buildItem,
                    firstPageErrorIndicatorBuilder: (_) => Center(
                      child: Text("An error occured"),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      child: Text('No Items to display'),
                    ),
                  ),
                  separatorBuilder: separatorBuilder,
                ),
        ),
      ),
    );

Widget _buildItem(
  BuildContext context,
  ArticleModel item,
  int index,
) =>
    SizedBox(
      height: _itemHeight,
      child: Text(
        item.id,
      ),
    );
