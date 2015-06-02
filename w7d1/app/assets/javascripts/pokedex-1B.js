Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  this.$pokeDetail.empty();
  var $detail = $('<div>').addClass("detail");
  var $image = $('<img>').attr("src", pokemon.escape("image_url"));
  var $toys = $('<ul>').addClass("toys");

  // TA: use event delegation
  $toys.on("click", this.selectToyFromList.bind(this));
  var content = "Name: " + pokemon.escape("name") + "<br>";
  content += "Attack: " + pokemon.escape("attack") + "<br>";
  content += "Defense: " + pokemon.escape("defense") + "<br>";
  content += "Poke Type: " + pokemon.escape("poke_type") + "<br>";
  content += "Moves: " + pokemon.escape("moves");

  var rootView = this;
  pokemon.fetch({
    success: function (collection){
      collection.toys().each(function (toy) {
        rootView.addToyToList(toy);
      });
    }
  });


  $detail.append($image);
  $detail.append($('<p>').html(content)).append($toys);

  this.$pokeDetail.append($detail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data("id");
  var pokemon = this.pokes.get({ "id": id });
  this.renderPokemonDetail(pokemon);
};
