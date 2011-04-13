# RQL for Ruby

This is a port of Kris Zyp's [RQL (Resource Query
Language)](https://github.com/kriszyp/rql) to Ruby.

## Installation

    $ gem install rql

The current parser uses ExecJS to run the RQL javascript parser. While
ExecJS is generally good about using the best available javascript
runtime, it's recommended that you use either:

- [therubyracer](https://github.com/cowboyd/therubyracer) runtime
  under Ruby 1.8/1.9;

- or [therubyrhino](https://github.com/cowboyd/therubyrhino) runtime
  under JRuby.

To specify **therubyracer** runtime:

    require 'rql'
    require 'v8'
    
    Rql.runtime = ExecJS::RubyRacerRuntime.new

To specify **therubyrhino** runtime under JRuby

    require 'rql'
    require 'rhino'
    
    Rql.runtime = ExecJS::RubyRhinoRuntime.new


## Usage

    require 'rql'
    query = Rql['id=5&name=foo']
    
    data = [
         {"id" => 1, "name" => "foo"},
         {"id" => 5, "name" => "foo"}        
    ]
    
    query.on(data) #=> [{"id" => 5, "name" => "foo"}]



## Notes

You should keep the following in mind:

- While the parsing of query strings should be identical to the
javascript implementation, execution of the queries may not behave in
exactly the same way.

- Which query operations are supported, and how they behave is entirely
dependent on the Evaluator class being
used. Rql::Evaluator::Enumerable implements the evaluation behavior
for Enumerable types. 

- Rql::Evaluator::Enumerable is probably broken, and is likely to
change. That said, it's the best example of how Evaluators are
currently implemented. 
