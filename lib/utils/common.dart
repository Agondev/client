const _acceptedImgFormats = [
  'gif',
  'png',
  'jpg',
  'jpeg',
];

bool isValidImageExtension(String string) {
  for (var item in _acceptedImgFormats) {
    if (string.endsWith(item)) {
      return true;
    }
  }
  return false;
}
