module Zune
  module XmlDsl

    class ::String

      # user_data.to_node_name returns userData
      def to_node_name

        first = true
        noded = ''
        self.split('_').each do |v|
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

    DEFAULT_NODE = 'user'

    def node
      @node ||= DEFAULT_NODE
    end

    def node=(node)
      @node = node
    end

    def context_template
      { :simple => [], :images => [], :arrays => [] }
    end

    def root_context
      @root_context ||= context_template
    end

    def current_context
      context_path.last
    end

    def context_path
      @context_path ||= [ root_context ]
    end

    def with_node(with_node)
      node = with_node
      yield
    end

    def simple_value(*values)
      values.each do |value|
        current_context[:simple] << { :name => value, :node => node }
      end
    end

    def image_value(*values)
      values.each do |value|
        current_context[:images] << { :name => value, :node => node }
      end
    end

    def create_array(name)
      array_context = context_template
      current_context[:arrays] << { :name => name, :context => array_context }
      context_path.push array_context
      yield
      context_path.pop
    end

    module Instance

      def parse_xml(xml)

        document = REXML::Document.new xml
        self.class.context.each do |node, properties|

          properties[:simple].each do |property|
            element_name = "#{node}/#{property.to_s.to_node_name}"
            value = document.root.elements[element_name].text
            instance_variable_set "@#{property}".to_sym, value
          end

          properties[:image].each do |property|
            element_name = "#{node}/image[@format='#{property.to_s.to_node_name}']/url"
            value = document.root.elements[element_name].text
            instance_variable_set "@#{property}".to_sym, value
          end

        end

      end
    end

  end
end