import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';
import 'package:newsapp/src/model/article_model.dart';

final firstPageItemList = [
  ArticleModel(
    id: "1",
    newsSite: 'newsSite 1',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 1',
    summary: 'summary 1',
  ),
  ArticleModel(
    id: "2",
    newsSite: 'newsSite 2',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 2',
    summary: 'summary 2',
  ),
  ArticleModel(
    id: "3",
    newsSite: 'newsSite 3',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 3',
    summary: 'summary 3',
  ),
  ArticleModel(
    id: "4",
    newsSite: 'newsSite 4',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 4',
    summary: 'summary 4',
  ),
  ArticleModel(
    id: "5",
    newsSite: 'newsSite 5',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 5',
    summary: 'summary 5',
  ),
  ArticleModel(
    id: "6",
    newsSite: 'newsSite 6',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 6',
    summary: 'summary 6',
  ),
  ArticleModel(
    id: "7",
    newsSite: 'newsSite 7',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 7',
    summary: 'summary 7',
  ),
  ArticleModel(
    id: "8",
    newsSite: 'newsSite 8',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 8',
    summary: 'summary 8',
  ),
  ArticleModel(
    id: "9",
    newsSite: 'newsSite 9',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 9',
    summary: 'summary 9',
  ),
  ArticleModel(
    id: "10",
    newsSite: 'newsSite 10',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 10',
    summary: 'summary 10',
  ),
];

final secondPageItemList = [
  ArticleModel(
    id: "11",
    newsSite: 'newsSite 11',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 11',
    summary: 'summary 11',
  ),
  ArticleModel(
    id: "12",
    newsSite: 'newsSite 12',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 12',
    summary: 'summary 12',
  ),
  ArticleModel(
    id: "13",
    newsSite: 'newsSite 13',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 13',
    summary: 'summary 13',
  ),
  ArticleModel(
    id: "14",
    newsSite: 'newsSite 14',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 14',
    summary: 'summary 14',
  ),
  ArticleModel(
    id: "15",
    newsSite: 'newsSite 15',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 15',
    summary: 'summary 15',
  ),
  ArticleModel(
    id: "16",
    newsSite: 'newsSite 16',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 16',
    summary: 'summary 16',
  ),
  ArticleModel(
    id: "17",
    newsSite: 'newsSite 17',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 17',
    summary: 'summary 17',
  ),
  ArticleModel(
    id: "18",
    newsSite: 'newsSite 18',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 18',
    summary: 'summary 18',
  ),
  ArticleModel(
    id: "19",
    newsSite: 'newsSite 19',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 19',
    summary: 'summary 19',
  ),
  ArticleModel(
    id: "20",
    newsSite: 'newsSite 20',
    publishedAt: 'May 20, 2021',
    imageUrl: 'image.com',
    url: 'article.com',
    title: 'title 20',
    summary: 'summary 20',
  ),
];

const pageSize = 10;

PagingState<int, ArticleModel> buildPagingStateWithPopulatedState(
  PopulatedStateOption filledStateOption,
) {
  switch (filledStateOption) {
    case PopulatedStateOption.completedWithOnePage:
      return PagingState(
        nextPageKey: null,
        itemList: firstPageItemList,
      );
    case PopulatedStateOption.errorOnSecondPage:
      return PagingState(
        nextPageKey: 2,
        itemList: firstPageItemList,
        error: Error(),
      );
    case PopulatedStateOption.ongoingWithOnePage:
      return PagingState(
        nextPageKey: 2,
        itemList: firstPageItemList,
      );
    case PopulatedStateOption.ongoingWithTwoPages:
      return PagingState(
        nextPageKey: 3,
        itemList: [...firstPageItemList, ...secondPageItemList],
      );
    case PopulatedStateOption.errorOnFirstPage:
      return PagingState(
        error: Error(),
      );
    case PopulatedStateOption.noItemsFound:
      return const PagingState(
        itemList: [],
      );

    default:
      return null;
  }
}

PagingController<int, ArticleModel> buildPagingControllerWithPopulatedState(
  PopulatedStateOption filledStateOption,
) {
  final state = buildPagingStateWithPopulatedState(
    filledStateOption,
  );

  return PagingController.fromValue(state, firstPageKey: 1);
}

enum PopulatedStateOption {
  errorOnSecondPage,
  completedWithOnePage,
  ongoingWithTwoPages,
  ongoingWithOnePage,
  errorOnFirstPage,
  noItemsFound,
}
