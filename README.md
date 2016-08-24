# mackerel-agent Dockerfile

## How to use this image

### Environment

If you don't set the env, mackerel-agent use the default env.

| name | default | description |
| --- | --- | --- |
| TZ | Asia/Tokyo |  |
| APIKEY |  | ※required |
| OPTS |  | ex) -role=develop:test |
| AUTO_RETIREMENT | 1 |  |
| PLUGINS |  | ex) docker,elasticsearch |


### Example

```bash
docker run -d --name mackerel-agent \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/mackerel-agent/:/var/lib/mackerel-agent/ \
  -e 'APIKEY=<APIKEY>' \
  -e 'OPTS=-v' \
  intimatemerger/mackerel-agent
```