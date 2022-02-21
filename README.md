## Запуск проекта

```
./bin/docker-db-prepare
docker-compose up
```

## Api

### Добавить IP-адрес к подсчету статистики

```
curl --location --request POST 'http://localhost:3000/api/v1/ip_addresses' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data": {
        "type": "ip_addresses",
        "attributes": {
            "ip": "127.0.0.1"
        }
    }
}'
```
### Удалить IP-адрес из подсчета статистики

```
curl --location --request DELETE 'http://localhost:3000/api/v1/ip_addresses/127.0.0.1' \
```

### Получение статистики для ip адреса
```
curl --location --request GET 'http://localhost:3000/api/v1/ip_reports/127.0.0.1?from=2022-02-21T10:00:00Z&to=2022-02-21T23:00:00Z'
```
