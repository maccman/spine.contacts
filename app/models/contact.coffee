Spine = require('spine')

class Contact extends Spine.Model
  @configure 'Contact', 'name', 'email', 'mobile', 'lat', 'lon'
  
  @extend Spine.Model.Local
  
  @filter: (query) ->
    return @all() unless query
    query = query.toLowerCase()
    @select (item) ->
      item.name?.toLowerCase().indexOf(query) isnt -1 or
      item.email?.toLowerCase().indexOf(query) isnt -1 or
      item.mobile?.indexOf(query) isnt -1
      
  addLocation: ->
    navigator?.geolocation.getCurrentPosition (position) =>
      @lat = position.coords.latitude
      @lon = position.coords.longitude
      @save()
  
  destroyLocation: ->
    @lat = null
    @lon = null
    @save()
        
module.exports = Contact