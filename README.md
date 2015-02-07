# Unconstrained

Unconstrained for Active Record converts exceptions raised because of
underlying database constraints to appropriate ActiveModel::Errors

## Usage

In your Gemfile:

```ruby
gem 'unconstrained'
```

## Notes

Only constraints that have to do with referential integrity are handled.
This is intentional, as these require a roundrip to the database anyway.
Constraints that can be enforced using validations in the application
should be checked that way.

Currently only handles PostgreSQL.

## Reasoning

Rails supports the `dependent` option on `has_one` / `has_many`
associations, which can be used to a similar effect, ie:

```ruby
has_many :children, dependent: :restrict_with_error
```

However, this has drawbacks. In the simple case, it offers no particular
advantage, since it still needs a roundrip to the database, and since no
locking takes place, there exists the possibility of an error in a
system under heavy use.

In more complex scenarios, errors are bound to occur. For example,
consider the following scenario:

```
parents
|
| <- dependent: :destroy
|
---children
   |
   | <- dependent: :restrict_with_error
   |
   ---grandchildren
```

Here ActiveRecord will never have an efficient way to proceed. It would
either have to delete the children en masse, leading to database errors
such as:

```
ActiveRecord::InvalidForeignKey: PG::ForeignKeyViolation: ERROR:
update or delete on table "children" violates foreign key constraint
"fk_rails_xxxxxxxxxx" on table "grandchildren"
DETAIL:  Key (id)=(xxxxxxxxxx) is still referenced from table "grandchildren".
```

Otherwise ActiveRecord would need to load and check every child record,
which would be extremely inefficient.  On the other hand, a relational
database, with the appropriate constraints defined, would handle the
operation swiftly and efficiently.

Now that Rails 4.2 supports foreign key constraints, one would simply
define in the migration:

```ruby
add_foreign_key :children, :parents, on_delete: :cascade
add_foreign_key :grandchildren, :children
```
and then the database exceptions would be handled by Unconstrained.
