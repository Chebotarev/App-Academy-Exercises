Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $item = $('<li>').addClass('poke-list-item').data({ "id": pokemon.get("id") });
  $item.text(pokemon.get("name") + " " + pokemon.get("poke_type"));
  this.$pokeList.append($item);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var root = this;

  this.pokes.fetch({
    success: function (pokemons, resp) {
      pokemons.each(function (pokemon) {
        root.addPokemonToList(pokemon);
      });
    }
  });
};
