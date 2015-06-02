Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $item = $('<li>').
    data("toy-id", toy.id).
    data("pokemon-id", toy.get("pokemon_id"));
  var content = "Name: " + toy.escape("name") + "<br>";
  content += "Happiness: " + toy.escape("happiness") + "<br>";
  content += "Price: " + toy.escape("price");
  $item.append(content);
  this.$pokeDetail.find("ul.toys").append($item);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.empty();
  var $detail = $('<div>').addClass("detail");
  var $img = $('<img>').attr("src", toy.get("image_url"));
  var content = "Name: " + toy.get("name") + "<br>";
  content += "Happiness: " + toy.get("happiness") + "<br>";
  content += "Price: " + toy.get("price");
  $detail.append($img).append(content);
  this.$toyDetail.append($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var pokemonId = $(event.target).data("pokemon-id");
  var toyId = $(event.target).data("toy-id");
  var toy = this.pokes.get({"id": pokemonId}).toys().get({"id": toyId});
  this.renderToyDetail(toy);
};
