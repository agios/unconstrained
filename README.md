# Unconstrained

Unconstrained for Active Record converts exceptions raised because of
underlying foreign key constraints to appropriate ActiveModel::Errors

For example, if trying to insert a record in a model `Book`, which
`belongs_to :author` using an invalid `author_id`, instead of getting
an exception such as:

```
PG::ForeignKeyViolation: ERROR:  insert or update on table "books" 
violates foreign key constraint "fk_rails_xxxxxxxxxx"
DETAIL:  Key (author_id)=(xxxxxxxxxx) is not present in table "authors".
```

you will now get a validation error on the field `author_id` with the 
message `"author is invalid"`

Conversely, when if trying to delete an author but books exist, instead of:

```
PG::ForeignKeyViolation: ERROR:  update or delete on table "authors" 
violates foreign key constraint "fk_rails_xxxxxxxxxx" on table "books"
DETAIL:  Key (id)=(xxxxxxxxxx) is still referenced from table "books".
```

you will now get a `base` validation error on the record with the 
message `"Cannot delete record because dependent books exist"`

![all tests](https://github.com/agios/unconstrained/actions/workflows/run-tests.yml/badge.svg?branch=master)

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