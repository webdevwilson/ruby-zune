require 'rexml/document'
require 'zune/xml_dsl'

module Zune

  class ZuneCard

    extend XmlDsl
    include XmlDsl::Instance

    simple_value :id, :label, :first_name, :status
    image_value :tile_big, :tile_small

    with_node 'user/manifest/userData'
      simple_value :name, :location, :bio, :total_plays, :user_id
      image_value :background_large, :background_small
    end

    with_node 'user/manifest/userData/badges'
      create_array :badges do
        simple_value :label, :description, :type
        image_value :badge_image_small, :badge_image_large
        object_value :album do
          simple_value :id, :label, :release_time, :url
          image_value :album_cover_small, :album_cover_large
          object_value :artist do
            simple_value :id, :label, :url
          end
        end
        object_value :artist do
          simple_value :id, :label, :url
        end
      end

    end

    attr_accessor :xml

    def initialize(zune_tag)
      @xml = get_xml(zune_tag)
      parse_xml(xml)
    end

    def get_xml(zune_tag)
      ''
    end



  end

  
  
end