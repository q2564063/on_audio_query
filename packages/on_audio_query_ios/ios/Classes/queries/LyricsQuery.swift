import Flutter
import MediaPlayer

class LyricsQuery {
    var args: [String: Any]
    var result: FlutterResult
    
    init() {
        self.args = try! PluginProvider.call().arguments as! [String: Any]
        self.result = try! PluginProvider.result()
    }

    func queryLyrics() {
        // The 'id' of the [Song] or [Album].
        let id = args["id"] as! Int
        
        
        var cursor: MPMediaQuery?
        var filter: MPMediaPropertyPredicate?
            
        let uri = 0
        switch uri {
        case 0:
            filter = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
            cursor = MPMediaQuery.songs()
        case 1:
            filter = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyAlbumPersistentID)
            cursor = MPMediaQuery.albums()
        case 2:
            filter = MPMediaPropertyPredicate(value: id, forProperty: MPMediaPlaylistPropertyPersistentID)
            cursor = MPMediaQuery.playlists()
        case 3:
            filter = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyArtistPersistentID)
            cursor = MPMediaQuery.artists()
        case 4:
            filter = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyGenrePersistentID)
            cursor = MPMediaQuery.genres()
        default:
            filter = nil
            cursor = nil
        }
        
        if cursor == nil || filter == nil {
            Log.type.warning("Cursor or filter has null value!")
            result(nil)
            return
        }
        
        Log.type.debug("Query config: ")
        Log.type.debug("\tid: \(id)")
        Log.type.debug("\turi: \(uri)")
        Log.type.debug("\tfilter: \(String(describing: filter))")

        cursor!.addFilterPredicate(filter!)
            
        // Filter to avoid audios/songs from cloud library.
        let cloudFilter = MPMediaPropertyPredicate(
            value: false,
            forProperty: MPMediaItemPropertyIsCloudItem
        )
        cursor?.addFilterPredicate(cloudFilter)
            
        // Query everything in background for a better performance.
        loadLyrics(cursor: cursor, uri: uri)
    }
    
    private func loadLyrics(cursor: MPMediaQuery!, uri: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            var item: MPMediaItem?
            
            // 'uri' == 0         -> artwork is from [Song]
            // 'uri' == 1, 2 or 3 -> artwork is from [Album], [Playlist] or [Artist]
            if uri == 0 {
                item = cursor!.items?.first
            } else {
                item = cursor!.collections?.first?.items[0]
            }
            
            var lyrics = item?.value(forProperty: MPMediaItemPropertyLyrics)
            
            DispatchQueue.main.async {
                // Avoid "empty" or broken image.
                // if artwork != nil, artwork!.isEmpty {
                //     if PluginProvider.showDetailedLog {
                //         Log.type.warning("Item (\(item?.persistentID ?? 0)) has a null or empty artwork")
                //     }
                //     artwork = nil
                // }
                
                self.result(lyrics)
            }
        }
    }
}
