::RedisSession = ConnectionPool::Wrapper.new(size: 30, timeout: 5) { Redis.connect }

#::RedisSession = ConnectionPool::Wrapper.new(size: 30, timeout: 5) { r.connect }
::APILimit = Ratelimit.new(:api_queries, redis: RedisSession)
