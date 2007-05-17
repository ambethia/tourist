module Ambethia

  class Tourist

    class << self

      # Load Tourist
      def see!
        ActionView::Base.send(:include, TourGuide)
      end

      # Wrap up an unrendered view in some html comments
      def trap(template, file_name)
        alpha = "\n<!-- BEGIN #{file_name} {{{ -->\n"
        omega = "\n<!-- END   #{file_name} }}} -->\n"
        alpha << template << omega
      end
      
    end
        
  end
  
  module TourGuide
    
    def self.included(base) #:nodoc:
      base.class_eval do
          alias_method_chain :compile_template, :guide
      end
    end
    
    protected
    
      # Helping you find your way in a foreign app.
      def compile_template_with_guide(extension, template, file_name, local_assigns)
        template = Tourist.trap(template, file_name) if extension.to_sym == :rhtml
        compile_template_without_guide(extension, template, file_name, local_assigns)
      end
      
  end
end