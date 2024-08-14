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
        
        var filter: MPMediaPropertyPredicate? = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
        var cursor: MPMediaQuery? = MPMediaQuery.songs()
        
        if cursor == nil || filter == nil {
            Log.type.warning("Cursor or filter has null value!")
            result(nil)
            return
        }
        
        Log.type.debug("Query config: ")
        Log.type.debug("\tid: \(id)")
        Log.type.debug("\tfilter: \(String(describing: filter))")

        cursor!.addFilterPredicate(filter!)
            
        // Filter to avoid audios/songs from cloud library.
        let cloudFilter = MPMediaPropertyPredicate(
            value: false,
            forProperty: MPMediaItemPropertyIsCloudItem
        )
        cursor?.addFilterPredicate(cloudFilter)
            
        // Query everything in background for a better performance.
        loadLyrics(cursor: cursor)
    }
    
    private func loadLyrics(cursor: MPMediaQuery!) {
        DispatchQueue.global(qos: .userInitiated).async {
            var item: MPMediaItem? = cursor!.items?.first
            
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
