Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail"
  },

  initialize: function(options) {
    this.collection = options.collection;
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex();
    }

    var pokemon = this._pokemonIndex.collection.get(id);
    // debugger;
    var pokemonDetail = new Pokedex.Views.PokemonDetail({
      model: pokemon
    });
    pokemonDetail.refreshPokemon({success: callback});
  },

  pokemonIndex: function (callback) {
    var pokemons = new Pokedex.Collections.Pokemon();
    this._pokemonIndex = new Pokedex.Views.PokemonIndex({
      collection: pokemons
    });
    this._pokemonIndex.refreshPokemon(this.pokemonDetail.bind(this));

    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  }
});

$(function () {
  var pokemons = new Pokedex.Collections.Pokemon();
  pokemons.fetch({
    success: function() {
      new Pokedex.Router({ collection: pokemons });
      Backbone.history.start();
    }
  });
});
