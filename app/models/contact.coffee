Spine = require('spine')

class Contact extends Spine.Model
  @configure 'Contact', 'name', 'email'
  
  @extend Spine.Model.Local
  
  @filter: (query) ->
    return @all() unless query
    query = query.toLowerCase()
    @select (item) ->
      item.name?.toLowerCase().indexOf(query) isnt -1 or
        item.email?.toLowerCase().indexOf(query) isnt -1
        
module.exports = Contact