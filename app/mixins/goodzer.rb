class Goodzer 
  self.site = "http://api.goodzer.com/products/v0.1/search_locations/?apiKey=7abbdf2e073c361c22f319bb8d545f4f&lat=37.381168365478516&lng=-122.08232879638672&query=strollers"
  self.element_name = "product"
  
  def stroller
    @def = "%lat=37.381168365478516&lng=-122.08232879638672%query=strollers"
    
  end
end