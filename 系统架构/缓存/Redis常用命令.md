

批量删除key

```sh
redis-cli -h 10.40.0.43 keys tutk_user_token:* | xargs redis-cli -h 10.40.0.43 del
```

