# excernan_avro

[![Build Status](https://travis-ci.org/postmates/excernan_avro.svg?branch=master)](https://travis-ci.org/postmates/excernan_avro)

An Elixir client for Cernan's Avro source.

## Usage 

The following example assumes you have an instance of Cernan's Avro source accepting connections on `localhost:2002`.

```elixir
schema = ExCernan.Avro.Schema.record(
  "User",
  [ExCernan.Avro.Schema.field("name", :string),
   ExCernan.Avro.Schema.field("favorite_number", :int),
   ExCernan.Avro.Schema.field("favorite_color", :string)],
 [{:namespace, "example.avro"}])

user1 = [{"name", "Foo Bar"}, {"favorite_number", 10}, {"favorite_color", "maroon"}]
user2 = [{"name", "Alice Bob"}, {"favorite_number", 32}, {"favorite_color", "greenish-gold"}]
users = [user1, user2]

# Sync publish users.
# Blocks until Cernan acknowledges the publication.
ExCernan.Avro.publish("example.avro.User", schema, users)

# Async publish users.
ExCernan.Avro.publish("example.avro.User", schema, users, %{:sync => false})

# Async publish users and sequence the publication by the term "fizzbuzz".
# Note - shard_by values must be hashable by phash2.
ExCernan.Avro.publish("example.avro.User", schema, users, %{:sync => false, :shard_by => "fizzbuzz"})
```

### Available Publication Options

As illustrated above, users can control various aspects of how their Avro payloads are published
by providing an optional `map()` to `publish`.

The following is a full listing of the options currently available by default:

| Option    | Type Spec             | Description                                                                       | Default               |
| :-------: | :-------------------: | :-------------------------------------------------------------------------------: | :-------------------: |
| sync      | boolean()             | Publish the given data synchronously?                                             | true                  |
| shard_by  | undefined or term()   | Value used to determine which shard / bucket the resulting Avro is published to.  | Random (undefined)    |

### Configuring Pools

`ExCernan.Avro` makes use of `cerlnan_avro` to publish data.

See [Configuring Pools](https://github.com/postmates/cerlnan_avro#configuring-pools) for details on
pool configuration.
