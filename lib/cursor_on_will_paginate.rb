module CursorOnWillPaginate

  def self.included base
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def each_with_cursor options = {}, &block 
      options[:per_page] ||= 1000
      options[:page] = 1
      collection = self.paginate( options )
      while !collection.blank?
        collection.each do |el|
          yield el
        end
        options[:page] += 1
        collection = self.paginate( options )
      end
    end
  end
end

ActiveRecord::Base.send :include, CursorOnWillPaginate
