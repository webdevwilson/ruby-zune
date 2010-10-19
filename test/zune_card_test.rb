$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'zune'

module Zune
 
  class Zune_card_test < Test::Unit::TestCase

    def setup
      test_file = File.join(File.dirname(__FILE__), 'test_data.xml')
      @zune_card = ZuneCard.load_from_file test_file
      @badge = @zune_card.badges.first
      @following = @zune_card.following.first
      @track = @zune_card.recent_spins.first
      @most_played = @zune_card.most_played.first
    end

    def test_zune_card_loads_basic_data
      assert_equal 'NoogaGamer', @zune_card.id
      assert_equal 'NoogaGamer', @zune_card.label
      assert_equal 'Kerry', @zune_card.first_name
      assert_equal 'checking out the new Zune features', @zune_card.status
      assert_equal 'Kerry', @zune_card.name
      assert_equal 'Tennessee', @zune_card.location
      assert_equal 'Father of two awesome boys, web developer, xbox gamer, pontooner, barbecuer, wannabe guitarist, and more...', @zune_card.bio
      assert_equal '39,367 plays', @zune_card.total_plays
      assert_equal 'afc268d2-87b7-48dc-bd86-cd761bf372a8', @zune_card.user_id
    end

    def test_zune_card_loads_basic_image_data
      assert_equal 'http://cache-tiles.zune.net/tiles//kp/aE/1HBpY3MvdTpdHlNZQEJVWwcFTVRUGFZmZmUwNzAwL2dhbWVycGljLmQAAAAAAAAA+6uWuA==663e.jpg', @zune_card.tile_big
      assert_equal 'http://cache-tiles.zune.net/tiles//kp/aE/1HBpY3MvdTpdHlNZQEJVWwcFTVRUGFZmZmUwNzAwL2dhbWVycGljLmQAAAAAAAAA+6uWuA==663e.jpg', @zune_card.tile_small
      assert_equal 'http://cache-tiles.zune.net/tiles//hR/00/0HBpY3MvdTpYHlReRV9CUQ0BAwYAXQcFFABDQjAwL3VzZXJjYXJkYmFja2dyb3VuZC5hAAAAAAAAAP8bHbE=1b5d.jpg', @zune_card.background_large
      assert_equal 'http://cache-tiles.zune.net/tiles//hR/00/0HBpY3MvdTpYHlReRV9CUQ0BAwYAXQcFFABDQjAwL3VzZXJjYXJkYmFja2dyb3VuZC5hAAAAAAAAAP8bHbE=1b5d.jpg', @zune_card.background_small
    end

    def test_correct_amount_of_badges
      assert_equal 93, @zune_card.badges.count
    end

    def test_badge_data

      # simple values
      assert_equal '70840e44-459c-489c-abbf-0af9a89fafa6', @badge.id
      assert_equal 'Bronze Album Power Listener', @badge.label
      assert_equal '200 or more plays', @badge.description
      assert_equal 'ActiveAlbumListener_Bronze', @badge.type
      assert_equal 'http://social.zune.net/xweb/lx/pic/minifeed/35x35-album-bronze.png', @badge.badge_image_small
      assert_equal 'http://social.zune.net/xweb/lx/pic/minifeed/75x75-album-bronze.png', @badge.badge_image_large

      # the album
      assert_equal '21570c02-0100-11db-89ca-0019b92a3933', @badge.album.id
      assert_equal 'Jason Mraz\'s Beautiful Mess: Live On Earth', @badge.album.label
      assert_equal '2009', @badge.album.release_time
      assert_equal 'http://social.zune.net/album/Jason-Mraz/Jason-Mraz\'s-Beautiful-Mess:-Live-On-Earth/21570c02-0100-11db-89ca-0019b92a3933/details', @badge.album.url
      assert_equal 'http://image.catalog.zune.net/v3.0/image/21570c02-0300-11db-89ca-0019b92a3933?resize=false&height=75', @badge.album.album_cover_small
      assert_equal 'http://image.catalog.zune.net/v3.0/image/21570c02-0300-11db-89ca-0019b92a3933?resize=false&height=150', @badge.album.album_cover_large
      assert_equal 'de490800-0600-11db-89ca-0019b92a3933', @badge.album.artist.id
      assert_equal 'Jason Mraz', @badge.album.artist.label
      assert_equal 'http://social.zune.net/artist/Jason-Mraz', @badge.album.artist.url

      # the artist
      assert_equal 'de490800-0600-11db-89ca-0019b92a3933', @badge.artist.id
      assert_equal 'Jason Mraz', @badge.artist.label
      assert_equal 'http://social.zune.net/artist/Jason-Mraz', @badge.artist.url
      
    end

    def test_correct_amount_of_following
      assert_equal 15, @zune_card.following.count
    end

    def test_following_data
                              
      assert_equal '55240b00-0600-11db-89ca-0019b92a3933', @following.id
      assert_equal 'Silversun Pickups', @following.label
      assert_equal 'http://social.zune.net/artist/Silversun-Pickups', @following.url
      assert_equal 'http://resources.zune.net/images/675fb187-4bdc-4070-bf33-f1e9fac9989b.PNG', @following.artist_image_large
      assert_equal 'http://resources.zune.net/images/90c53981-f355-4872-902c-2f5b413b12fe.PNG', @following.artist_image_small
      
    end

    def test_playlist_counts
      assert_equal 8, @zune_card.favs.count
      assert_equal 8, @zune_card.recent_spins.count
    end

    def test_playlist_data

      assert_equal '81138806-0100-11db-89ca-0019b92a3933', @track.id
      assert_equal 'Poor Man Blues (Album Version)', @track.label
      assert_equal 'http://social.zune.net/redirect?type=track&id=81138806-0100-11db-89ca-0019b92a3933&target=web&action=buy&source=profile', @track.buy_url
      assert_equal 'http://social.zune.net/my/sendmessage.aspx?AlbumName=The+Guitar+Song&AlbumArtUrl=%2fxweb%2flx%2fpic%2fConstellation_75x75.jpg&mediaid=81138806-0100-11db-89ca-0019b92a3933&type=Song&TrackName=Poor+Man+Blues+(Album+Version)&ArtistName=Jamey+Johnson&ru=%2fprofile', @track.send_url
      assert_equal 'http://social.zune.net/profile/setfavorite.ashx?aid=81138806-0100-11db-89ca-0019b92a3933&ru=http%3a%2f%2forigin-social.zune.net%2fzcard%2fusercardservice.ashx%3fzunetag%3dNoogaGamer', @track.set_fav_url

      # album info
      assert_equal '4e138806-0100-11db-89ca-0019b92a3933', @track.album.id
      assert_equal 'The Guitar Song', @track.album.label
      assert_equal '2010', @track.album.release_time
      assert_equal 'http://social.zune.net/xweb/lx/pic/Constellation_75x75.jpg', @track.album.album_cover_small
      assert_equal 'http://social.zune.net/xweb/lx/pic/Constellation_160x160.jpg', @track.album.album_cover_large
      assert_equal 'http://social.zune.net/album/Jamey-Johnson/The-Guitar-Song/4e138806-0100-11db-89ca-0019b92a3933/details', @track.album.url

      #artist info
      assert_equal '2a670b00-0600-11db-89ca-0019b92a3933', @track.album.artist.id
      assert_equal 'Jamey Johnson', @track.album.artist.label
      assert_equal 'http://social.zune.net/artist/Jamey-Johnson', @track.album.artist.url

    end

    def test_most_played_count
      assert_equal 8, @zune_card.most_played.count
    end

    def test_most_played_data

      assert_equal '55240b00-0600-11db-89ca-0019b92a3933', @most_played.id
      assert_equal 'Silversun Pickups', @most_played.label
      assert_equal 'http://social.zune.net/artist/Silversun-Pickups', @most_played.url
      assert_equal 'http://resources.zune.net/images/675fb187-4bdc-4070-bf33-f1e9fac9989b.PNG', @most_played.artist_image_large
      assert_equal 'http://resources.zune.net/images/90c53981-f355-4872-902c-2f5b413b12fe.PNG', @most_played.artist_image_small
      assert_equal '7,070,684 plays', @most_played.total_plays

    end

  end

end
