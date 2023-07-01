- #### :one: Используя Я.Облако, создать виртуальную машину (операционную систему выберите на свое усмотрение, рекомендуемое минимальное количество ресурсов: 4 vCPU, 4GB RAM, 50GB HDD).

> машину создадим терраформом, файл `instances.tf` 

- #### :two: Развернуть (используя бесплатный пробный период) Artifactory.

> `jfrog arifactory` установлен и запущен 

![Alt text](images/image.png) 

- #### :three: Настроить на Artifactory проксирование pip-репозитория pipy.org  

> настройки артифактори  

![Alt text](images/image-1.png)  

- #### :four: Предоставить разработчикам репозиторий для публикации результатов разработки.  

> файл `.pypirc`  

```bash
[distutils]
index-servers = local
[local]
repository: http://158.160.111.92:8081/artifactory/api/pypi/pypi-local
username: *****
password: *****
```
> тестовая загрузка пакета

![Alt text](images/image-2.png)

> пакет доступен в репозитории  

![Alt text](images/image-3.png)  

- #### :five: Отправить ментору конфигурационный файл pip.conf, настроенный для работы с Artifactory в качестве репозитория (вместо стандартного pipy.org), и ссылку на Artifactory, развернутую на вашей машине. Интерфейс должен быть доступен из интернета.

> настройки `pip.conf`

```bash
[global]
index-url =
http://****:****@158.160.111.92:8081/artifactory/api/pypi/pypi-local/simple
```

> файлы ставятся из прокси `jfrog`

![Alt text](images/image-5.png)  




