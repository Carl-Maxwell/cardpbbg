# this file defines the coding style for this project

(some of these rules were derived from https://github.com/copycopter/style-guide)

## General

* Keep lines under 80 characters.
* Delete, don't comment out.

## Naming conventions

* use CamelCase for class names
  * acronyms should be uppercase (RNG not rng)
* user snake_case for methods and variables
  * acronyms should be lowercase (rng not RNG)

## Whitespace

* two-space tabs. Space characters, not tabs.
* single line blocks should user `{}`, multi-lines should use `do end`
* parallel lines should be visually parallel
  * (vertically align tokens on consecutive lines, as in:)
  * (don't always do this ... there's no hard rule)
  * (but fifty parallel lines should be visually parallel)
```ruby
def some_function
  start = User   .find(params[:id])
  line  = Session.find(params[:session_id])
end
```
* use spaces to do so,
* do not do so if the two lines have different indentations, as in this case:
```ruby
def time(times, date, bad, ideal_range)
  bad_times  = times.map { |time| time < date || time == bad   ? time.x : nil }
  good_times = times.map { |time| time > date && time.is_good? ? time.x : nil }

  if good_times.any?
    start, stop = ideal_range
    good_times.select { |time| time > start && time < stop ? time : nil }
  else
    nil
  end
end
```
* Don't use an empty line at the beginning or end of methods, blocks or conditionals
* Do use one empty line *between* methods, blocks and conditionals in the same scope.
* Do not use more than one empty line anywhere.
```ruby
rawr = user_input

if rawr
  rawr.some_function!

  rawr = [5, 3, 2].reduce do |x, y|
    x + y * rawr
  end

  rawr
end

if !something || !rawr
  a_function_that_does_something("super rawr!");
end
```
* Break up long lines like so:
```ruby
SomeClassWithALongEnoughNameToDemonstrate
  .where("SELECT something WHERE stuff IS NULL")
  .joins(:cards)
  .where(card_which: 14)
  .pluck(:name, :email)
  .map { |name, email| "#{name} <#{email}>" }
```
* not like so
```ruby
SomeClassWithALongEnoughNameToDemonstrate.where("SELECT something WHERE stuff IS NULL")
                                         .join(:cards)
                                         .where(card_which: 14)
                                         .pluck(:name, :email)
                                         .map { |name, email| "#{name} <#{email}>" }
```
* calling functions on `end` statements is acceptable, though ugly.
```ruby
second_sequence = player_2.cards.select do |card|
  foe = first_sequence.first
  card.attack > foe.attack
end.any?
```
* Similarly with `)`
```ruby
Session.where(
  user: user,
  computer_token: session[:computer_token]
).destroy_all
```

## Comments

Comments come in three 'sizes':

```ruby
#-----------------------------------------------------------------------------
# Heading 1
#-----------------------------------------------------------------------------

#
# Heading 2
#

# Heading 3
```

* Do not use any other style of comment (external libraries may use alternate forms).
* Comments should always be on a line of their own.
  * (so, not on the same line as some code.)
* always put one space after the `#` and before the text.
* Heading sizes 1 and 2 should have an empty line before and after them
  * Unless they're at the beginning or end of a scope block.

Use comments to:
* group 'paragraphs' of code into 'chapters'
* explain complex, counter-intuitive, or obscure lines of code (such as the use of `BasicObject`, etc)

Multi-line forms of heading 3 are allowable:
```ruby
# this isn't really a monkeypatch,
#   it's a utility that *enables* monkeypatching
```

* The additional lines should be indented (using 2 spaces).

## Schema style

* standarize column names:
  * name (not username/title/etc)
