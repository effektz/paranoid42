# Paranoid42

[paranoid2](https://github.com/anjlab/paranoid2) ideas (and code) adapted for rails 4.2

Rails 4.2 introduced adequate record, but in order to take advantage of the improvements, default_scope can't be used. Paranoid42 removes the default scope from Paranoid2. This means you have to be explicit about telling your app not to return deleted records.

Paranoid42 removes the default scope and adds a new `not_deleted` method to your paranoid classes.

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

[Benchmarks](https://gist.github.com/effektz/f18e1be522a328a981b9)

## Paranoid2

Rails 4 defines `ActiveRecord::Base#destroy!` so `Paranoid42` gem use `force: true` arg to force destroy.

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

# will restore object and all it's associations
c.restore

# will restore only this object without it's associations
c.restore(associations: false)

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
