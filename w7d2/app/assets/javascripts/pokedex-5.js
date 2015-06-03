Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li': 'selectPokemonFromList'
  },

  initialize: function (options) {
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPokemonToList);
  },

  addPokemonToList: function (pokemon) {
    if (pokemon) {
      var content =  JST["pokemonListItem"]({ pokemon: pokemon });
      this.$el.append(content);
    } else {
    }
    return this;
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: function() {
        options.success && options.success();
      }
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.forEach(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).attr("data-id");
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    // debugger;
    pokemon.fetch({
      success: function () {
        var fragment = "pokemon/" + id;
        Backbone.history.navigate(fragment, { trigger: true });

      }
    });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    debugger;
    $('#pokedex .pokemon-detail').html(this.$el);
    this.model.fetch({
      success: function () {
        this.render();
      }.bind(this)
    });
  },

  render: function () {
    var details =  JST["pokemonDetail"]({ pokemon: this.model });
    this.$el.html(details);

    this.model.toys().forEach(function (toy) {
      this.$el.append(JST["toyListItem"]({ toy: toy }));
    }.bind(this));
  },

  selectToyFromList: function (event) {
    var id = $(event.currentTarget).attr("data-id");
    var toy = this.model.toys().get(id);
    toy.fetch({
      success: function () {
        var toyDetail = new Pokedex.Views.ToyDetail({
          model: toy
        });
        toyDetail.render();
      }
    });
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    $('#pokedex .toy-detail').html(this.$el);
    var toyDetails = JST["toyDetail"]({ toy: this.model, pokemons: [] });
    this.$el.html(toyDetails);
  }
});
//
// $(function () {
//   var pokemons = new Pokedex.Collections.Pokemon();
//   var pokemonIndex = new Pokedex.Views.PokemonIndex({
//     collection: pokemons
//   });
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
