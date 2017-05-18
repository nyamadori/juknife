# Juknife

[![Build Status](https://travis-ci.org/nyamadori/juknife.svg?branch=master)](https://travis-ci.org/nyamadori/juknife)

A Ruby library for Web scraping. It allows to describe scraping nodes and text structurally and declaratively.

For example, scraping on Google search can be written as follows:

```ruby
class GoogleSearchAgent < Juknife::Agent
  request do
    get 'https://www.google.co.jp/search'
    user_agent 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)'
    query do
      {
        q: params[:query]
      }
    end
  end

  scraping do
    items :results, '#ires .g' do
      item :title, 'h3'
      item :url, '.kv > cite'
      item :description, '.st'
    end
  end
end

agent = GoogleSearchAgent.new
agent.scrape(query: 'test')
# =>
# {:results=>
#   [
#     {:title=>"testの意味・用例｜英辞郎 on the WEB：アルク",
#      :url=>"https://eow.alc.co.jp/search?q=test",
#      :description=>
#       "test 【1自動】 試験［検査］を受ける 《医・化学》検査［分析］を行う 〔試験で... - アルクがお\n" +
#       "届けする進化するオンライン英和・和英辞書データベース。一般的な単語や連語から、\n" +
#       "イディオム、専門用語、スラングまで幅広く収録。"}
#     }
#   ]
# }
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'juknife'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install juknife

## Usage

[TODO]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/juknife. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
