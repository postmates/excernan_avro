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

`ExCernan.Avro` both publish via `poolboy` backed connection pools.

By default, users are given a single pool which is locally addressable as `cerlnan_avro` initialized with
default arguments. However, users can make use of their `Application` environment to configure their own pools.

**Note** - When not using or configuring a pool named `cerlnan_avro` calls to `publish/3` and `publish/4` will
no longer work as they assume usage of the `cerlnan_avro` pool.  Variations of these calls which allow users to
select the pool to publish from are available.

The following example demonstrates reconfiguring the `cerlnan_avro` pool with 100 connections and 200 overflow workers:

#### Elixir

```elixir
    config :cerlnan_avro,
        pools: [
            {:cerlnan_avro,
             %{:pool_size => 100,
               :pool_overflow => 200
              }
            }]
```

#### Pool Config

For a complete listing of configuration options available see - [cerlnan_avro](https://github.com/postmates/cerlnan_avro#pool-config).
