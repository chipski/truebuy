class ProductSearch
  
  def self.model_name
    "ProductSearch"
  end
  def name
    "ProductSearch"
  end
  
  def query(categories=[], brands=[], topics=[])
    if categories == []
      []  #todo add back brands and topics
    else
      @products = Product.joins(:categories).where(:categories=>{:id=>categories})
      unless [nil, "", []].include?(brands)
        @products = @products + Product.where(:brands=>{:id=>brands})
      end
      #Product.joins(:categories).where("categories_products.category_id in ?", categories)
      Product.joins(:categories).where(:categories=>{:id=>categories})
      unless [nil, "", []].include?(topics)
        @products = @products + Product.where(:topics=>{:id=>topics})
      end
    end
    @products.uniq
  end
  
  def query2()
    # Scopes
    # scope :in_groups, lambda do |groups|
    #   joins(:groups).where(:groups => {:group_id => groups}).
    #   joins(:gfiles).where('gfiles.id = versions.gfile_id').
    #   where('groups.id = gfiles.group_id')
    # end
    
  end
end