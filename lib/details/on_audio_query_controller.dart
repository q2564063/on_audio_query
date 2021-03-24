part of on_audio_query;

///Interface and Main method for use on_audio_query
class OnAudioQuery {
  //Dart <-> Kotlin communication
  static const String _CHANNEL_ID = "com.lucasjosino.on_audio_query";
  static const MethodChannel _channel = const MethodChannel(_CHANNEL_ID);

  // Check if [requestPermission] is null or not, if true, will set to [false].
  static bool _checkPermission(bool requestPermission) {
    if (requestPermission != null) return requestPermission;
    return false;
  }

  // Check if [order] is null or not, if true, will set to [ASC_OR_SMALLER].
  static int _checkOrder(OrderType order) {
    if (order != null) return order.index;
    return OrderType.ASC_OR_SMALLER.index;
  }

  /// Used to return Songs Info based in [SongModel].
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [orderType] is used to define if order will be Ascending or Descending.
  /// * [sortType] is used to define list sort.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [orderType] is null, will be set to [ASC_OR_SMALLER].
  /// * If [sortType] is null, will be set to [title].
  /// * If Android >= Q/10 [artwork] will return null, in this case, it's necessary use [queryArtworks]
  Future<List<SongModel>> querySongs(
      [SongSortType sortType,
      OrderType orderType,
      bool requestPermission]) async {
    final List<dynamic> resultSongs =
        await _channel.invokeMethod("querySongs", {
      "requestPermission": _checkPermission(requestPermission),
      "sortType":
          sortType != null ? sortType.index : SongSortType.DEFAULT.index,
      "orderType": _checkOrder(orderType)
    });
    return resultSongs.map((songInfo) => SongModel(songInfo)).toList();
  }

  /// Used to return Songs Info based in [SongModel].
  ///
  /// This method is similar to [querySongs], but, will return all audio types. For example: WhatsApp Audios
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [orderType] is used to define if order will be Ascending or Descending.
  /// * [sortType] is used to define list sort.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [orderType] is null, will be set to [ASC_OR_SMALLER].
  /// * If [sortType] is null, will be set to [title].
  /// * If Android >= Q/10 [artwork] will return null, in this case, it's necessary use [queryArtworks]
  Future<List<SongModel>> queryAudios(
      [SongSortType sortType,
      OrderType orderType,
      bool requestPermission]) async {
    final List<dynamic> resultSongs =
        await _channel.invokeMethod("queryAudios", {
      "requestPermission": _checkPermission(requestPermission),
      "sortType":
          sortType != null ? sortType.index : SongSortType.DEFAULT.index,
      "orderType": _checkOrder(orderType)
    });
    return resultSongs.map((songInfo) => SongModel(songInfo)).toList();
  }

  /// Used to return Albums Info based in [AlbumModel].
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [orderType] is used to define if order will be Ascending or Descending.
  /// * [sortType] is used to define list sort.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [orderType] is null, will be set to [ASC_OR_SMALLER].
  /// * If [sortType] is null, will be set to [AlbumName].
  /// * If Android >= Q/10 [artwork] will return null, in this case, it's necessary use [queryArtworks]
  Future<List<AlbumModel>> queryAlbums(
      [AlbumSortType sortType,
      OrderType orderType,
      bool requestPermission]) async {
    final List<dynamic> resultAlbums =
        await _channel.invokeMethod("queryAlbums", {
      "requestPermission": _checkPermission(requestPermission),
      "sortType":
          sortType != null ? sortType.index : AlbumSortType.DEFAULT.index,
      "orderType": _checkOrder(orderType)
    });
    return resultAlbums.map((albumInfo) => AlbumModel(albumInfo)).toList();
  }

  /// Used to return Artists Info based in [ArtistModel].
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [orderType] is used to define if order will be Ascending or Descending.
  /// * [sortType] is used to define list sort.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [orderType] is null, will be set to [ASC_OR_SMALLER].
  /// * If [sortType] is null, will be set to [ArtistName].
  /// * Mp3 only support one image, artist image don't exist.
  Future<List<ArtistModel>> queryArtists(
      [ArtistSortType sortType,
      OrderType orderType,
      bool requestPermission]) async {
    final List<dynamic> resultArtists =
        await _channel.invokeMethod("queryArtists", {
      "requestPermission": _checkPermission(requestPermission),
      "sortType":
          sortType != null ? sortType.index : ArtistSortType.DEFAULT.index,
      "orderType": _checkOrder(orderType)
    });
    return resultArtists.map((artistInfo) => ArtistModel(artistInfo)).toList();
  }

  /// Used to return Playlists Info based in [PlaylistModel].
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [orderType] is used to define if order will be Ascending or Descending.
  /// * [sortType] is used to define list sort.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [orderType] is null, will be set to [ASC_OR_SMALLER].
  /// * If [sortType] is null, will be set to [PlaylistName].
  Future<List<PlaylistModel>> queryPlaylists(
      [PlaylistSortType sortType,
      OrderType orderType,
      bool requestPermission]) async {
    final List<dynamic> resultPlaylists =
        await _channel.invokeMethod("queryPlaylists", {
      "requestPermission": _checkPermission(requestPermission),
      "sortType":
          sortType != null ? sortType.index : PlaylistSortType.DEFAULT.index,
      "orderType": _checkOrder(orderType)
    });
    return resultPlaylists
        .map((playlistInfo) => PlaylistModel(playlistInfo))
        .toList();
  }

  /// Used to return Genres Info based in [GenreModel].
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [orderType] is used to define if order will be Ascending or Descending.
  /// * [sortType] is used to define list sort.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [orderType] is null, will be set to [ASC_OR_SMALLER].
  /// * If [sortType] is null, will be set to [GenreName].
  Future<List<GenreModel>> queryGenres(
      [GenreSortType sortType,
      OrderType orderType,
      bool requestPermission]) async {
    final List<dynamic> resultGenres =
        await _channel.invokeMethod("queryGenres", {
      "requestPermission": _checkPermission(requestPermission),
      "sortType":
          sortType != null ? sortType.index : GenreSortType.DEFAULT.index,
      "orderType": _checkOrder(orderType)
    });
    return resultGenres.map((genreInfo) => GenreModel(genreInfo)).toList();
  }

  /// Used to return Songs/Audios Info from a specific queryType based in [SongModel].
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [type] is used to define where audio will be query.
  /// * [where] is used to query audios from specific method.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<List<SongModel>> queryAudiosFrom(AudiosFromType type, String where,
      [bool requestPermission]) async {
    final List<dynamic> resultSongsFrom =
        await _channel.invokeMethod("queryAudiosFrom", {
      "requestPermission": _checkPermission(requestPermission),
      "type": type.index,
      "where": where
    });
    return resultSongsFrom.map((songInfo) => SongModel(songInfo)).toList();
  }

  /// Used to return Songs Artwork.
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION.
  /// * [type] is used to define if artwork is from audios or albums.
  /// * [format] is used to define type [PNG] or [JPEG].
  /// * [size] is used to define image quality.
  ///
  /// Usage and Performance:
  ///
  /// * Using [PNG] will return a better image quality but a slow performance.
  /// * Using [Size] greater than 200 probably won't make difference in quality but will cause a slow performance.
  ///
  /// Important:
  ///
  /// * This method is only necessary for API >= 29 [Android Q/10].
  /// * If [queryArtworks] is called in Android below Q/10, will return null.
  /// * If [requestPermission] is null, will be set to [false].
  /// * If [format] is null, will be set to [JPEG] for better performance.
  /// * If [size] is null, will be set to [200] for better performance
  /// * We need this method separated from [querySongs/queryAudios] because return [Uint8List] and using inside query causes a slow performance.
  Future<Uint8List> queryArtworks(int id, ArtworkType type,
      [ArtworkFormat format, int size, bool requestPermission]) async {
    final Uint8List finalArtworks =
        await _channel.invokeMethod("queryArtworks", {
      "requestPermission": _checkPermission(requestPermission),
      "type": type.index,
      "id": id,
      "format": format != null ? format.index : ArtworkFormat.JPEG.index,
      "size": size != null ? size : 200
    });
    return finalArtworks;
  }

  //Playlist methods

  /// Used to create a Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistName] is used to add a name to Playlist.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  /// * This method create a playlist using [External Storage], all apps will be able to see this playlist
  Future<bool> createPlaylist(String playlistName,
      [bool requestPermission]) async {
    final bool resultCreatePl = await _channel.invokeMethod("createPlaylist", {
      "requestPermission": _checkPermission(requestPermission),
      "playlistName": playlistName
    });
    return resultCreatePl;
  }

  /// Used to remove/delete a Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistId] is used to check if Playlist exist.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<bool> removePlaylist(int playlistId, [bool requestPermission]) async {
    final bool resultRemovePl = await _channel.invokeMethod("removePlaylist", {
      "requestPermission": _checkPermission(requestPermission),
      "playlistId": playlistId
    });
    return resultRemovePl;
  }

  /// Used to add a specific song/audio to a specific Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistId] is used to check if Playlist exist.
  /// * [audioId] is used to add specific audio to Playlist.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<bool> addToPlaylist(int playlistId, int audioId,
      [bool requestPermission]) async {
    final bool resultAddToPl = await _channel.invokeMethod("addToPlaylist", {
      "requestPermission": _checkPermission(requestPermission),
      "playlistId": playlistId,
      "audioId": audioId
    });
    return resultAddToPl;
  }

  /// Used to remove a specific song/audio from a specific Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistId] is used to check if Playlist exist.
  /// * [audioId] is used to remove specific audio from Playlist.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<bool> removeFromPlaylist(int playlistId, int audioId,
      [bool requestPermission]) async {
    final bool resultRemoveFromPl =
        await _channel.invokeMethod("removeFromPlaylist", {
      "requestPermission": _checkPermission(requestPermission),
      "playlistId": playlistId,
      "audioId": audioId
    });
    return resultRemoveFromPl;
  }

  /// Used to query song/audio from a specific Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistId] is used to check if Playlist exist.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<bool> audiosFromPlaylist(int playlistId,
      [bool requestPermission]) async {
    final bool resultAudiosFromPl =
        await _channel.invokeMethod("audiosFromPlaylist", {
      "requestPermission": _checkPermission(requestPermission),
      "playlistId": playlistId,
    });
    return resultAudiosFromPl;
  }

  /// Used to change song/audio position from a specific Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistId] is used to check if Playlist exist.
  /// * [from] is the old position from a audio/song.
  /// * [to] is the new position from a audio/song.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<bool> moveItemTo(int playlistId, int from, int to,
      [bool requestPermission]) async {
    final bool resultMoveItem = await _channel.invokeMethod("moveItemTo", {
      "requestPermission": _checkPermission(requestPermission),
      "playlistId": playlistId,
      "from": from,
      "to": to
    });
    return resultMoveItem;
  }

  /// Used to rename a specific Playlist
  ///
  /// Parameters:
  ///
  /// * [requestPermission] is used for request or no Android STORAGE PERMISSION
  /// * [playlistId] is used to check if Playlist exist.
  /// * [newName] is used to add a new name to a Playlist.
  ///
  /// Important:
  ///
  /// * If [requestPermission] is null, will be set to [false].
  Future<bool> renamePlaylist(int playlistId, String newName,
      [bool requestPermission]) async {
    final bool resultRenamePl = await _channel.invokeMethod("renamePlaylist", {
      "renamePlaylist": _checkPermission(requestPermission),
      "playlistId": playlistId,
      "newPlName": newName
    });
    return resultRenamePl;
  }

  //Permissions methods

  /// Used to check Android permissions status
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * If return true [READ] and [WRITE] permissions is Granted, else [READ] and [WRITE] is Denied.
  Future<bool> permissionsStatus() async {
    final bool resultStatus = await _channel.invokeMethod("permissionsStatus");
    return resultStatus;
  }

  /// Used to request Android permissions.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * If return true [READ] and [WRITE] permissions is Granted, else [READ] and [WRITE] is Denied.
  Future<bool> permissionsRequest() async {
    final bool resultRequest =
        await _channel.invokeMethod("permissionsRequest");
    return resultRequest;
  }

  //Device Information

  /// Used to return Device SDK Version
  ///
  /// Usage:
  ///
  /// * Permissions and Storage in Android are very complicated, get device info may help.
  ///
  /// Important:
  ///
  /// * This method will always return a int.
  Future<int> getDeviceSDK() async {
    final int resultSDK = await _channel.invokeMethod("getDeviceSDK");
    return resultSDK;
  }

  /// Used to return Device Version
  ///
  /// Usage:
  ///
  /// * Permissions and Storage in Android are very complicated, get device info may help.
  ///
  /// Important:
  ///
  /// * This method will always return a String.
  Future<String> getDeviceRelease() async {
    final String resultRelease =
        await _channel.invokeMethod("getDeviceRelease");
    return resultRelease;
  }

  /// Used to return Device Version [Alphabetical]
  ///
  /// Usage:
  ///
  /// * Permissions and Storage in Android are very complicated, get device info may help.
  ///
  /// Important:
  ///
  /// * This method will always return a String.
  Future<String> getDeviceCode() async {
    final String resultCode = await _channel.invokeMethod("getDeviceCode");
    return resultCode;
  }
}