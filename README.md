# opsworks_rails_redis_config-cookbook

This chef cookbook will setup a redis configuration file for Rails. The file is created in the shared
configuration directory and a link is created from the current release to this file.

It is expected that an initializer has been setup in config/initializers/redis.rb with the following
content:

REDIS_CONFIG = YAML::load_file(Rails.root.join('config', 'redis.yml'))
@redis = Redis.new(:host => REDIS_CONFIG['host'], :port => REDIS_CONFIG['port'])

## Supported Platforms

Opsworks

## Usage

### opsworks_rails_redis_config::default

Include the following in your custom json:

{
  "deploy":
  {
    "solots":
    {
      "redis":
      {
        "host": "solots-redis-queue.vchhxk.0001.usw2.cache.amazonaws.com",
        "port": "6379"
      }
    }
  }
}

## License and Authors

Author:: kjoyner (<kjoyner>)
