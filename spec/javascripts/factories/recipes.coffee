Factory.define "recipe", ->
  @sequence 'id'
  @sequence 'name', (i) ->
    "Recipe #{i}"
