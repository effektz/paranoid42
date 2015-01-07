# Paranoid42

Retain soft-deleting functionality without losing AdequateRecord's speed improvements. A fork of [paranoid2](https://github.com/anjlab/paranoid2).

Rails 4.2 introduced adequate record, but in order to take advantage of the improvements, default_scope can't be used ([Release Notes](http://edgeguides.rubyonrails.org/4_2_release_notes.html)). Paranoid42 removes the default scope, and adds a new `not_deleted` method to your paranoid classes ([Benchmarks](https://gist.github.com/effektz/f18e1be522a328a981b9)).

So this:

```
> Special.where(name: "test")

SELECT "specials".* FROM "specials" WHERE (deleted_at IS NULL) AND "specials"."name" = $1  [["name", "test"]]
```

Turns into this:

```
> Special.not_deleted.where(name: "test")

SELECT "specials".* FROM "specials" WHERE (deleted_at IS NULL) AND "specials"."name" = $1  [["name", "test"]]
```

If you would rather use a shorter method, just create a method with your preferred name, and reference `not_deleted`:

```
def active
  not_deleted
end
```

Counter Caches have also been tied into Paranoid42. Soft-deleting a record will decrement the association counter cache, and recovering a record will incremenet the association counter cache.

## Installation

Add this line to your application's Gemfile:

    gem 'paranoid42'

And then execute:

    $ bundle

## Usage

Add `deleted_at: datetime` to your model.
Generate and run migrations.

```
rails g migration AddDeletedAtToClients deleted_at:datetime
```
```ruby
class AddDeletedAtToClients < ActiveRecord::Migration
  def change
    add_column :clients, :deleted_at, :datetime
  end
end
```

```ruby

class Client < ActiveRecord::Base
  paranoid
end

c = Client.find(params[:id])

# will set destroyed_at time
c.destroy

# will recover object and all it's associations
c.recover

# will recover only this object without it's associations
c.recover(associations: false)

# will destroy object for real
c.destroy(force: true)

# also useful scopes are available
Client.only_deleted

```

### With paperclip

```ruby
class Listing < ActiveRecord::Base
  has_attached_file :image,
    # ...
    preserve_files: true
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
