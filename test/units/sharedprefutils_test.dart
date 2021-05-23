import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/src/service_locator.dart';
import 'package:newsapp/src/utils/sharedprefsutil.dart';

void main() {
  group(
    'Test reading and writing data from storage',
    () {
      SharedPrefsUtil _sharedPref;

      setUpAll(
        () {
          // We call these to register the services
          setupServiceLocator();

          // We then create SharedPref instance
          _sharedPref = sl.get<SharedPrefsUtil>();
        },
      );

      tearDownAll(
        () async {
          // We read all the saved values and remove them
          var favs = await _sharedPref.getFavorites();

          for (String fav in favs) {
            await _sharedPref.removeFavorite(fav);
          }
        },
      );

      test(
        'Test we can read data',
        () async {
          // setup a null variable
          var favs;

          // Confirm it is null
          expect(favs, isNull);

          // Assign it data after reading from our storage
          favs = await _sharedPref.getFavorites();

          // Confirm it not null anymore
          expect(favs, isNotNull);

          // Confirm the type is List of strings
          expect(favs.runtimeType.toString(), 'List<String>');
        },
      );

      test(
        'Test we can save data',
        () async {
          // setup a null variable
          var favs;

          // Confirm it is null
          expect(favs, isNull);

          // We save one data
          await _sharedPref.setFavorite('test');

          // Assign it data after reading from our storage
          favs = await _sharedPref.getFavorites();

          // Confirm it not null anymore
          expect(favs, isNotNull);

          // Confirm the type is List of strings
          expect(favs.runtimeType.toString(), 'List<String>');

          // Confirm we get one element
          expect(favs.length, 1);
        },
      );
    },
  );
}
