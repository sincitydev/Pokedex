//  This file was automatically generated and should not be edited.

import Apollo

public final class PokemonsQuery: GraphQLQuery {
  public static let operationString =
    "query Pokemons($first: Int!) {\n  pokemons(first: $first) {\n    __typename\n    name\n    image\n    types\n  }\n}"

  public var first: Int

  public init(first: Int) {
    self.first = first
  }

  public var variables: GraphQLMap? {
    return ["first": first]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("pokemons", arguments: ["first": GraphQLVariable("first")], type: .list(.object(Pokemon.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(pokemons: [Pokemon?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "pokemons": pokemons.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var pokemons: [Pokemon?]? {
      get {
        return (snapshot["pokemons"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Pokemon(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "pokemons")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes = ["Pokemon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("image", type: .scalar(String.self)),
        GraphQLField("types", type: .list(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String? = nil, image: String? = nil, types: [String?]? = nil) {
        self.init(snapshot: ["__typename": "Pokemon", "name": name, "image": image, "types": types])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The name of this Pokémon
      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var image: String? {
        get {
          return snapshot["image"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "image")
        }
      }

      /// The type(s) of this Pokémon
      public var types: [String?]? {
        get {
          return snapshot["types"] as? [String?]
        }
        set {
          snapshot.updateValue(newValue, forKey: "types")
        }
      }
    }
  }
}