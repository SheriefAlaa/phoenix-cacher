# PhoenixCacher

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Load test using wrk
```
wrk -t10 -c25 -d60s  --script ./random_alpha.lua http://localhost:4000/reaction
```

# Example test output:
```
Running 1m test @ http://localhost:4000/reaction
  10 threads and 25 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    22.71ms   19.21ms 471.84ms   95.21%
    Req/Sec    94.55     27.65   171.00     75.08%
  56279 requests in 1.00m, 13.00MB read
Requests/sec:    937.13
Transfer/sec:    221.64KB
```