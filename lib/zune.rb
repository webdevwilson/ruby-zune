require 'xml/mapping'

module Zune
  
  class ::Symbol

    # user_data.to_node_name returns userData
    def to_node_name

      first = true
      noded = ''
      self.to_s.split('_').each do |v|
        if first
          noded = v
          first = false
        else
          noded += v[0..0].upcase + v[1..-1]
        end
      end
      noded
    end

  end

  class Badge; end;
  class Album; end;
  class Artist; end;
  class Track; end;
  
  class ZuneCard

    include XML::Mapping

    # simple properties
    [:id, :label, :first_name, :status].each do |name|
      text_node name, "user/#{name.to_node_name}", :default_value => nil
    end

    [:name, :location, :bio, :total_plays, :user_id].each do |name|
      text_node name, "user/manifest/userData/#{name.to_node_name}", :default_value => nil
    end
    
    # images
    [:tile_big, :tile_small].each do |format|
      text_node format, "user/image[@format='#{format.to_node_name}']/url", :default_value => nil
    end

    [:background_large, :background_small].each do |format|
      text_node format, "user/manifest/userData/image[@format='#{format.to_node_name}']/url", :default_value => nil
    end

    array_node :badges, 'user/manifest/userData/badges', 'badge', :class => Badge, :default_value => []
    array_node :following, 'user/manifest/userData/following', 'followinfo/artist', :class => Artist, :default_value => []

    [ :favs, :recent_spins ].each do |playlist|
      array_node playlist, "user/manifest/playlists/playlist[@type='#{playlist}']", 'track', :class => Track, :default_value => []
    end

    array_node :most_played, 'user/manifest/playlists/playlist[@type=\'most_played\']', 'artist', :class => Artist, :default_value => []

  end

  class Badge

    include XML::Mapping

    [ :id, :label, :description, :type ].each do |name|
      text_node name, name.to_s, :default_value => nil
    end

    [ :badge_image_small, :badge_image_large ].each do |format|
      text_node format, "image[@format='#{format.to_node_name}']/url", :default_value => nil
    end

    object_node :album, 'album', :class => Album, :default_value => nil
    object_node :artist, 'artist', :class => Artist, :default_value => nil
    
  end
  
  class Album

    include XML::Mapping

     [ :id, :label, :release_time, :url ].each do |name|
       text_node name, name.to_node_name, :default_value => nil
    end

    [ :album_cover_large, :album_cover_small ].each do |format|
      text_node format, "image[@format='#{format.to_node_name}']/url", :default_value => nil
    end

    object_node :artist, 'artist', :class => Artist, :default_value => nil

  end

  class Artist

    include XML::Mapping

    [ :id, :label, :url, :total_plays ].each do |name|
      text_node name, name.to_node_name, :default_value => nil
    end

    [ :artist_image_large, :artist_image_small ].each do |format|
      text_node format, "image[@format='#{format.to_node_name}']/url", :default_value => nil
    end

  end

  class Track

    include XML::Mapping

    [ :id, :label ].each do |name|
      text_node name, name.to_node_name, :default_value => nil
    end

    [ :buy, :send, :set_fav ].each do |url|
      text_node "#{url}_url".to_sym, "#{url.to_node_name}URL", :default_value => nil
    end

    object_node :album, 'album', :default_value => nil

  end
  
end