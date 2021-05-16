echo on
flutter clean && git status && git add . && git commit -m "end of day auto commit" && git push -f && flutter build web && firebase deploy --only hosting